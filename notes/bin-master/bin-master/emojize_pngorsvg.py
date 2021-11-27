#! /usr/bin/env python3
# -*- coding: utf-8; mode: python -*-
""" Substitue any :emojis: in the input document with a small HTML code for a link to a PNG or SVG image.

- See https://stackoverflow.com/questions/42087466/sphinx-extension-to-use-github-markdown-emoji-in-sphinx
- Requirements:
   + 'markdown' from https://pythonhosted.org/Markdown/install.html
   + 'pymdownx.emoji' from https://facelessuser.github.io/pymdown-extensions/installation/

I use it with a small Bash script :

```bash
BUILDDIR=_build/html

for i in "$BUILDDIR"/*.html; do
    # Convert :emojis: to  PNG/SVG in HTML output (from GFM Markdown), see https://stackoverflow.com/questions/42087466/sphinx-extension-to-use-github-markdown-emoji-in-sphinx
    emojize_pngorsvg.py "$i" > "$i".new   # new file
    wdiff -3 "$i" "$i".new       # print the difference
    mv -vf "$i".new "$i"         # write back to the first file
done
```

- *Date:* 07/04/2017
- *Author:* Lilian Besson, (C) 2017
- *Licence:* MIT Licence (http://lbesson.mit-license.org)
"""

from __future__ import print_function, division  # Python 2 compatibility if needed

import re

try:
    from markdown import markdown
except ImportError:
    print("Error, module 'markdown' was not found, install it with 'pip install markdown' ...")

try:
    import pymdownx.emoji
except ImportError:
    print("Error, module 'pymdownx' was not found, install it with 'pip install pymarkdown-extensions' ...")


USE_SVG = False


def emojize(s, use_svg=USE_SVG):
    """Call markdown.markdown() on s."""
    emoji_generator = pymdownx.emoji.to_svg if use_svg else pymdownx.emoji.to_png
    extension_configs = {
        'pymdownx.emoji': {
            'emoji_generator': emoji_generator
        }
    }
    res = markdown(s,
                   extensions=['pymdownx.emoji'],
                   extension_configs=extension_configs
                  )
    return res.replace('<p>', '').replace('</p>', '')


def match_to_emoji(m, use_svg=USE_SVG):
    """Call emoji.emojize on m.group()."""
    return emojize(m.group(), use_svg=use_svg)


def emojize_all(s, use_svg=USE_SVG):
    """Convert all emojis :aliases: of the string s to emojis in UTF-8."""
    return re.sub(r":([a-z_-]+):", lambda s2: match_to_emoji(s2, use_svg=use_svg), s)


def main(path, use_svg=USE_SVG):
    """Handle the file given by its path."""
    with open(path, 'r') as f:
        for line in f.readlines():
            print(emojize_all(line, use_svg=use_svg), end='')


if __name__ == '__main__':
    from sys import argv
    if '--svg' in argv:
        USE_SVG = True
        while '--svg' in argv:
            del argv[argv.index('--svg')]
    for arg in argv[1:]:
        main(arg, use_svg=USE_SVG)

# End of emojize.py
