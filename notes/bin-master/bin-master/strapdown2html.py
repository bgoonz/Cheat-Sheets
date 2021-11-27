#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" Convert some Markdown/StrapDown.js files to a single, simple HTML (.html) file,
which looks as a StrapDown.js powered page, but is autonomous and *does not* require JavaScript at all.

I tried to do it as (durtily) well as possible (and I included a couple of nice features).

Features:
- include a link to SquirtFr (http://lbesson.bitbucket.org/squirt/),
- include the bootstrap theme, cf. http://bootswatch.com/united for all the possibilities,
- support UTF-8 (TODO try with another encoding?),
- quick and pretty, even if the script is really DURTY...

Links:
- more information on StrapDown.js can be found here http://lbesson.bitbucket.org/md/,
- another script I wrote for StrapDown.js is strapdown2pdf, here http://lbesson.bitbucket.org/md/strapdown2pdf.html
- (TODO) Similarly, this page http://lbesson.bitbucket.org/md/strapdown2html.html will give info about that program strapdown2html.py

Copyright: 2015, Lilian Besson.
License: GPLv3.
"""

from __future__ import print_function  # Python 2/3 compatibility !
import sys
import codecs
import markdown
import re
import os.path
from bs4 import BeautifulSoup, SoupStrainer

__author__ = "Lilian Besson"
__version__ = "0.3.1"

# TODO: improve conformity with StrapDown.js Markdown parser:
# nested list for instance, generic source code printer etc.

try:
    try:
        # Load ansicolortags (Cf. http://ansicolortags.readthedocs.io/)
        from ansicolortags import printc
    except ImportError as e:
        print("Optional dependancy (ansicolortags) is not available, using regular print function.")
        print("  You can install it with : 'pip install ansicolortags' (or sudo pip)...")
        # Load ANSIColors (Cf. http://pythonhosted.org/ANSIColors-balises/)
        from ANSIColors import printc
except ImportError:
    print("Optional dependancy (ANSIColors) is not available, using regular print function.")
    print("  You can install it with : 'pip install ANSIColors-balises' (or sudo pip)...")

    def printc(*a, **kw):
        print(*a, **kw)

# Load some Markdown extensions (Cf. https://pythonhosted.org/Markdown/extensions/index.html)
try:
    import markdown.extensions
    list_extensions = [
        'markdown.extensions.extra',  # https://pythonhosted.org/Markdown/extensions/extra.html
        'markdown.extensions.smarty',  # https://pythonhosted.org/Markdown/extensions/smarty.html
        'markdown.extensions.headerid',  # https://pythonhosted.org/Markdown/extensions/header_id.html
        'markdown.extensions.tables',  # https://pythonhosted.org/Markdown/extensions/tables.html
        'markdown.extensions.smart_strong',  # https://pythonhosted.org/Markdown/extensions/smart_strong.html
        # 'urlize'  # https://github.com/r0wb0t/markdown-urlize
    ]
    try:
        # From https://github.com/selcuk/markdown-urlify
        from markdown.preprocessors import Preprocessor
        from markdown.extensions import Extension

        urlfinder = re.compile(r'((([A-Za-z]{3,9}:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+(:[0-9]+)?|'
                               r'(?:www\.|[\-;:&=\+\$,\w]+@)[A-Za-z0-9\.\-]+)((?:/[\+~%/\.\w\-_]*)?\??'
                               r'(?:[\-\+=&;%@\.\w_]*)#?(?:[\.!/\\\w]*))?)')

        class URLify(Preprocessor):
            def run(self, lines):
                return [urlfinder.sub(r'<\1>', line) for line in lines]

        class URLifyExtension(Extension):
            def extendMarkdown(self, md, md_globals):
                md.preprocessors.add('urlify', URLify(md), '_end')

        urlify_ext = URLifyExtension()
        # list_extensions.append(urlify_ext)
        # FIXME improve support for that extension
    except:
        printc(" <INFO> Failed to define the 'urlify' extension.<white>")
except:
    list_extensions = []
    # No extension

# Fix UTF-8 output
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

beta = False
eraseFileAlreadyThere = False


def main(argv=[], path='/tmp', outfile='test.html', title='Test', use_jquery=False):
    """ Convert every input file from Markdown to HTML, and concatenate all them to an output."""

    printc("<green>Starting main, with:<white>")
    # FIXME printc does not handle UTF-8 correctly ! AAAH!
    print("path='{path}', outfile='{outfile}'.".format(path=path, outfile=outfile))
    print("And the title is:", title)
    fullpath = os.path.join(path, outfile)

    printc("<magenta>The output file will be <white>'<u>{fullpath}<U>'.".format(fullpath=fullpath))

    with open(fullpath, "w") as html_file:
        html_file = codecs.getwriter('utf-8')(html_file)
        # Writing the head of the HTML file
        html_file.write(u"""<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" name="viewport">
    <meta charset="utf-8">
    <title>{title}</title>
    <link href="http://perso.crans.org/besson/_static/md/themes/united.min.css" rel="stylesheet">
    <link href="http://perso.crans.org/besson/_static/md/strapdown.min.css" rel="stylesheet">
    <link href="http://perso.crans.org/besson/_static/md/themes/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="http://perso.crans.org/besson/_static/prism/prism.css" rel="stylesheet">
    <link rel="shortcut icon" href="http://perso.crans.org/besson/_static/.favicon.ico">
    <meta name="author" content="Lilian Besson">
    <meta name="generator" content="https://bitbucket.org/lbesson/bin/src/master/strapdown2html.py">
""".format(title=title))
        # Include jquery, and some plugins. Useless except if there is a table in the input document
        # FIXME improve detection
        if use_jquery:
            html_file.write(u"""
    <script type="text/javascript" src="http://perso.crans.org/besson/_static/jquery.js"></script>
    <script type="text/javascript" src="http://perso.crans.org/besson/_static/jquery.quicksearch.min.js"></script>
    <script type="text/javascript" src="http://perso.crans.org/besson/_static/jquery.smooth-scroll.min.js"></script>\n""")
        # Beginning of the header
        html_file.write(u"""</head>
<body>
<div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <div id="headline" class="brand">
                    <span id="title" style="font-size:115%;">{title}</span>
                </div>
""".format(title=title))
        # Last part of the navbar
        html_file.write(u"""
                <div id="headline-copyrights" class="brand">
                    Generated with <a href="https://bitbucket.org/lbesson/bin/src/master/strapdown2html.py">Python</a>,
                    by <a href="http://perso.crans.org/besson/">Lilian Besson</a>.
                    Based on <a title="http://lbo.k.vu/md" href="http://lbesson.bitbucket.org/md/index.html">StrapDown.js</a>
                    (theme <a title="More information on this theme, on bootswatch.com." href="http://bootswatch.com/united"><i>united</i></a>),
                    <!-- hosted on <a href="http://perso.crans.org/besson/">perso.crans.org/besson</a>. -->
                </div>
                <div id="headline-squirt" class="brand">
                    <a title="Quick read with SquirtFR. Check http://lbesson.bitbucket.org/squirt/ for more information."
                    href="javascript:(function(){sq=window.sq;if(sq&amp;&amp;sq.closed){window.sq.closed&amp;&amp;window.document.dispatchEvent(new%20Event('squirt.again'));}else{sq=window.sq||{};sq.version='0.4';sq.host='http://lbesson.bitbucket.org/squirt';sq.j=document.createElement('script');sq.j.src=sq.host+'/squirt.js?src=strapdown.min.js';document.body.appendChild(sq.j);}})();">[QuickRead]</a>
                </div>
            </div>
        </div>
    <!-- </div> -->
</div>
<div id="content" class="container" style="font-size:140%;">""")
        # Include the jQuery.QuickSearch plugin (no by default).
        if use_jquery:
            html_file.write(u"""
    <blockquote class="pull-right" style="right-margin: 5%;">
        <h2>Search on that table?</h2>
            <p>(Thanks to the <a href="http://deuxhuithuit.github.io/quicksearch/">QuickSearch</a> <a href="https://www.jQuery.com/">jQuery</a> plugin.)</p>
            <form><fieldset>
                <input type="text" name="search" value="" id="id_search" placeholder="Search on that table" autofocus />
            </fieldset></form>
    </blockquote><hr><br>""")
        # Not useful anymore, my script works fine.
        if beta:
            html_file.write(u"""
    <div class="alert alert-dismissable alert-warning">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h2>Warning!</h2>
        <p>This page has been converted from <a href="https://en.wikipedia.org/wiki/Markdown">Markdown</a> documents, with a Python script.<br>
        This <a href="https://bitbucket.org/lbesson/bin/src/master/strapdown2html.py">script</a> is still experimental! If needed, please <a href="https://bitbucket.org/lbesson/bin/issues/new" title="It's free, open to anyone, quick and easy!">fill a bug report</a>?</p>
    </div><br><hr>""")
        html_file.write(u"""\n<!-- First file -->\n""")

        # Now, work with each file.
        for inputfile in argv:
            try:
                printc("# <INFO> Trying to read from the file '<green><u>{inputfile}<reset><white>'.".format(inputfile=inputfile))
                with open(inputfile, 'r') as openinputfile:
                    printc(" I opened it, to '{openinputfile}'.".format(openinputfile=openinputfile))
                    # FIXME detect encoding better?
                    openinputfile = codecs.getreader('utf-8')(openinputfile)
                    printc(" <INFO> Codec manually changed to utf8.<white>")
                    html_text = "\t<!-- Failed to read from '{inputfile}'... This comment should have been replaced with the content of that file, converted to pure HTML... -->".format(inputfile=inputfile)

                    # Read that file !
                    markdown_text = openinputfile.read()
                    printc(" I just read from that file.")
                    if beta:
                        print(markdown_text)  # yes this works, useless now

                    # Let try to convert this text to HTML from Markdown
                    try:
                        # First, let try to see if the input file was not a StrapDown.js file.
                        try:
                            only_xmp_tag = SoupStrainer("xmp")
                            html = BeautifulSoup(markdown_text, "html.parser", parse_only=only_xmp_tag, from_encoding="utf-8")
                            if beta:
                                print(" BTW, this html read with Beautiful soup has the encoding,", html.original_encoding)
                            x = html.xmp
                            printc(" <black>BeautifulSoup<white> was used to read the input file as an HTML file, and reading its first xmp tag.")
                            # new_markdown_text = unicode(x.prettify("utf-8"), encoding="utf-8")
                            new_markdown_text = unicode(x.encode("utf-8"), encoding="utf-8")
                            printc(" I found the xmp tag and its content. Printing it:")
                            # OMG this is so durty ! FIXME do better?
                            if beta:
                                print(type(new_markdown_text))
                                print(new_markdown_text)
                            printc(" Now lets replaced '<xmp>' --> '' and '</xmp>' --> ''. Lets go!")
                            markdown_text = new_markdown_text.replace('<xmp>', '').replace('</xmp>', '')
                            printc(" Yeah, I replaced '<xmp>' --> '' and '</xmp>' --> ''. I did it!")
                            # Add code to add the good Prism.js class to <code> and <pre>, to color the code accordingly.
                            markdown_text = markdown_text.replace('```python', '<pre><code class="language-python" style="font-size:145%;">')
                            markdown_text = markdown_text.replace('```bash', '<pre><code class="language-bash" style="font-size:145%;">')
                            markdown_text = markdown_text.replace('```', '</code></pre>')
                            # This should be good.
                        except Exception as e:
                            printc(" <warning> Exception found: <yellow>{e}<white>.".format(e=e))
                            printc("  ===> <WARNING> I tried to read the file as a StrapDown.js powered file, but failed.<white>\n <magenta>I will now read it as a simple Markdown file.<white>")

                        # This is so durty... FIXME do better?
                        try:
                            markdown_text = markdown_text.replace('<!DOCTYPE html><html><head><meta charset="utf-8"/><title>', '<h1>')
                            markdown_text = markdown_text.replace('<!DOCTYPE html><html><head><meta charset="UTF-8"/><title>', '<h1>')
                            markdown_text = markdown_text.replace('</title></head><body><xmp>', '</h1>')
                            markdown_text = markdown_text.replace('</title></head><body><xmp theme="united">', '</h1>')
                            markdown_text = markdown_text.replace('<xmp theme="united">', '')
                            markdown_text = markdown_text.replace('</title></head><body><xmp theme="cyborg">', '</h1>')
                            markdown_text = markdown_text.replace('<xmp theme="cyborg">', '')
                            markdown_text = markdown_text.replace('<p></xmp><script type="text/javascript" src="http://perso.crans.org/besson/s/md/strapdown.min.js"></script></body></html></p>', '')
                            printc(" <INFO> Now I replace '<xmp>' --> '' and '</xmp>' --> ''. Lets go!<white>")
                        except:
                            printc(" I tried (again) to replace '<xmp>' --> '' and '</xmp>' --> '' byt failed")
                        # Alright, let us convert this MD text to HTML
                        printc(" Let convert the content I read to HTML with markdown.markdown.")
                        if beta:
                            print(markdown_text)
                        # FIXME: use markdown.markdownFromFile instead (simpler ?)
                        markdown_text = markdown_text.replace('&gt; ', '> ')
                        # Cf. https://pythonhosted.org/Markdown/reference.html#markdownFromFile
                        html_text = markdown.markdown(markdown_text, extensions=list_extensions)
                        # BETA: improve how tables look like
                        html_text = html_text.replace('<table>', '<table class="table table-striped table-bordered">')
                        printc(" I converted from Markdown to HTML: yeah!!<white>")
                    # Oups ! Bug !
                    except Exception as e:
                        printc("<ERROR> Exception found: <yellow>{e}<white>.".format(e=e))
                        printc(" ===> <WARNING> I failed to markdownise these lines. Next!<reset><white>")

                    # Now we have that html_text, lets write to the output file (append mode).
                    html_file.write(html_text)
                    printc(" <blue>I wrote this to the output file '{html_file}'<white>.".format(html_file=html_file))
                    # Done for that reading from that file

                html_file.write("\n<!-- End of the HTML converted from the file '{inputfile}'. -->\n<br><hr><br>\n<!-- Next file -->\n".format(inputfile=inputfile))
            # Opening the input file failed !
            except Exception as e:
                printc("<ERROR> Exception found: <yellow>{e}<white>.".format(e=e))
                printc(" ==> <ERROR>: Failed to read from the file {inputfile}. Going to the next one.<reset><white>\n".format(inputfile=inputfile))

        if use_jquery:
            html_file.write(u"""
    <script type="text/javascript">
        $('input#id_search').quicksearch('table tbody tr');
        $('a').smoothScroll({
            offset: ((screen.width > 680) ? -60 : 0), preventDefault: true,
            direction: 'top', easing: 'swing', speed:  350, autoCoefficent: 3,
        });
    </script>""")
        # Print the © message
        html_file.write(u"""
    <div class="alert alert-success pull-right">
        <h4>© 2015 <a title="Check out my web-pages!" href="http://perso.crans.org/besson/">Lilian Besson</a>, generated by <a href="https://bitbucket.org/lbesson/bin/src/master/strapdown2html.py" title="Python 2.7 is cool!">an open-source Python script</a>.</h4>
    </div>
</div>
<script type="text/javascript" src="http://perso.crans.org/besson/_static/prism/prism.js"></script>
<noscript><img alt="GA|Analytics" style="visibility:hidden;display:none;" src="http://perso.crans.org/besson/beacon/{fullpath}?pixel"/></noscript>
<script type="text/javascript" src="http://perso.crans.org/besson/_static/ga.js" async defer></script>
</body></html>
""".format(fullpath=fullpath))
    return True


# Now let us use that thing.
if __name__ == '__main__':
    args = sys.argv
    # J'ai la flemme, je fais la gestion des options à la main. Et j'écris ce commentaire en français, OHOO!
    if '-?' in args or '-h' in args or '--help' in args:
        printc("""<yellow>strapdown2html.py<white>: -h | [options] file1 [file2 [file3 ..]]

Convert the input files (Markdown (.md) or HTML (.html) StrapDown.js-powered) to one autonomous HTML file.

Options:
    <magenta>-?|-h|--help<white>:\n\t\tdisplay this help,
    <magenta>-o|--out<white>:\n\t\tspecify the output file. Default is based on the first file name.
    <magenta>-t|--title<white>:\n\t\tspecify the title of the output. Default is based on the first file name (autodetection is not perfect).
    <magenta>-v|--view<white>:\n\t\topen the output file when done (default is not to do it).
    <magenta>--use-jquery<white>:\n\t\tforce to include jQuery and the jQuery.QuickSearch plugin (in case of a table for example).
    <magenta>-f|--force<white>:\n\t\teven if the output file is present, <red>erase it<white> (default is to find a new name).

Warning:
    Experimental! Almost done?

Copyright: 2015, Lilian Besson.
License: GPLv3.""")
        exit(1)

    # OK get it from the user
    out = "/tmp/test.html"
    if '-o' in args:
        out = str(args.pop(1 + args.index('-o')))
        args.remove('-o')
    if '--out' in args:
        out = str(args.pop(1 + args.index('--out')))
        args.remove('--out')

    # OK get from the user or from the file
    title = ''
    if '-t' in args:
        title = args.pop(1 + args.index('-t'))
        args.remove('-t')

    if '--title' in args:
        title = args.pop(1 + args.index('--title'))
        args.remove('--title')

    if '--force' in args:
        eraseFileAlreadyThere = True
        args.pop(args.index('--force'))

    if '-f' in args:
        eraseFileAlreadyThere = True
        args.pop(args.index('-f'))

    use_jquery = False
    if '--use-jquery' in args:
        use_jquery = True
        args.pop(args.index('--use-jquery'))

    # Cleverly detect the title. So durty, again!
    i = 0
    while title == '':
        i += 1
        try:
            # with open(args[i], 'r') as file1:
            with codecs.open(args[i], 'r', encoding='utf-8') as file1:
                try:
                    contentfile1 = file1.read()
                    # FIXME experimental detection of the need for QuickSearch
                    # use_jquery = use_jquery or ((contentfile1.find('<table>') >= 0) or (contentfile1.find('') >= 0))
                    title = re.search("<title>[^<]+</title>", contentfile1).group()
                    title = title.replace('<title>', '').replace('</title>', '')
                except Exception as e:
                    # printc("<ERROR> Exception found: <yellow>{e}<white>.".format(e=e))
                    printc("<WARNING> Failed to read title from the file '{file1}'.<white>".format(file1=file1))
        except:
            break
    if title == '':
        printc("<WARNING> I tried to read the title in one of the input file, but failed.<white>\n")
        title = '(No title for that StrapDown document)'

    # Try to guess path+outfile from the first inputfile.
    if out == "/tmp/test.html":
        try:
            out = args[1].replace('.md', '.html').replace('.markdown', '.html')
            while os.path.exists(out):
                if eraseFileAlreadyThere:
                    # OMG, so bad! Only for Linux! FIXME
                    import distutils.file_util  # Mais quel débile !
                    # distutils.file_util.copy_file(out, '/tmp/')
                    distutils.file_util.copy_file(out + '~', '/tmp/')
                    distutils.file_util.move_file(out, out + '~')
                else:
                    out = out.replace('.html', '__new.html')
                if len(out) > 100:
                    break
        except:
            printc("<WARNING> I tried to guess the output file myself, but failed. Let use '/tmp/test.html'...<white>")

    path = os.path.dirname(out) if out else '/tmp/'
    outfile = os.path.basename(out) if out else 'test.html'

    # Calling main
    main(args[1:], path=path, outfile=outfile, title=title, use_jquery=use_jquery)
    printc("\n<green>Done, I wrote to the file '{outfile}' in the dir '{path}'.<white>".format(path=path, outfile=outfile))

    if '-v' in args or '--view' in args:
        try:
            printc("Opening that document in your favorite browser...")
            import webbrowser  # Thanks to antigravity.py!
            webbrowser.open(os.path.join(path, outfile))
        except Exception as e:
            printc("But I failed in opening that page to show you the content")
