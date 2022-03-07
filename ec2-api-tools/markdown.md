# MARKDOWN

This is intended as a quick reference and showcase. For more complete info, see [John Gruber's original spec](http://daringfireball.net/projects/markdown/) and the [Github-flavored Markdown info page](http://github.github.com/github-flavored-markdown/).

Note that there is also a Cheatsheet specific to Markdown Here if that's what you're looking for. You can also check out more Markdown tools.

### Tools

#### Editors

- [StackEdit](https://stackedit.io): In-browser MD document editor
- [Minimalist Online Markdown Editor](http://markdown.pioul.fr)
- [Mou](http://25.io/mou/): macOS editor
- [Haroopad](http://pad.haroopress.com/user.html): Cross-platform editor

### Libraries

#### JavaScript

- [Marked](https://github.com/chjj/marked)
- [Remarkable](https://github.com/jonschlinkert/remarkable)
- [PageDown](https://code.google.com/p/pagedown/) (and [PageDown Extra](https://github.com/jmcmanus/pagedown-extra))
- [markdown-it](https://github.com/markdown-it/markdown-it)
- [Gitdown](https://github.com/gajus/gitdown): GitHub markdown preprocessor
- [reMarked.js](https://github.com/leeoniya/reMarked.js): HTML-to-Markdown processor
- [Kramed](https://github.com/GitbookIO/kramed): Fork of Marked

**Table of Contents**

Headers\
Emphasis\
Lists\
Links\
Images\
Code and Syntax Highlighting\
Tables\
Blockquotes\
Inline HTML\
Horizontal Rule\
Line Breaks\
YouTube Videos

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com)

[I'm a reference-style link](https://www.mozilla.org)

I'm a relative reference to a repository file

[You can use numbers for reference-style link definitions](http://slashdot.org)

Or leave it empty and use the [link text itself](http://www.reddit.com).

URLs and URLs in angle brackets will automatically get turned into links. http://www.example.com or [http://www.example.com](http://www.example.com) and sometimes example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

Code blocks are part of the Markdown spec, but syntax highlighting isn't. However, many renderers -- like Github's and _Markdown Here_ -- support syntax highlighting. Which languages are supported and how those language names should be written will vary from renderer to renderer. _Markdown Here_ supports highlighting for dozens of languages (and not-really-languages, like diffs and HTTP headers); to see the complete list, and how to write the language names, see the [highlight.js demo page](http://softwaremaniacs.org/media/soft/highlight/test.html).

```
Inline `code` has `back-ticks around` it.
```

Inline `code` has `back-ticks around` it.

Blocks of code are either fenced by lines with three back-ticks ` ``` `, or are indented with four spaces. I recommend only using the fenced code blocks -- they're easier and only they support syntax highlighting.

````
```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

```python
s = "Python syntax highlighting"
print s
```

```
No language indicated, so no syntax highlighting.
But let's throw in a <b>tag</b>.
```
````

```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

```python
s = "Python syntax highlighting"
print s
```

```
No language indicated, so no syntax highlighting in Markdown Here (varies on Github).
But let's throw in a <b>tag</b>.
```

Please add any tips and tricks that you come up with. For now it'll be a flat list and we'll add structure as needed.

**Table of Contents**

Pasting from Clipboard (without tears)\
Using an email signature\
Footnotes\
Using other TeX math formulae renderers\
Changing the Main Font (and other overall styles)\
Getting fancy with inline HTML\
Cool CSS stuff\
Creating more complex tables\
Getting original Markdown from sent email\
Using Header Anchor Links

\
Pasting from Clipboard (without tears) <a href="#pasting" id="pasting"></a>

---

If text is pasted from the clipboard with formatting intact, it can negatively impact the rendering of Markdown (i.e., it can make it super messed up). When pasting into an email that you plan on rendering with Markdown Here, you should try to paste as plain text.

#### Windows and Linux <a href="#windows-and-linux" id="windows-and-linux"></a>

- **Chrome**: Context menu: "Paste as plain text". Hotkey: `Ctrl+Shift+V`.
- **Firefox**: There doesn't seem to be a menu item. Hotkey: `Ctrl+Shift+V`.
- **Thunderbird, Postbox**: _Edit_ menu and context menu: "Paste Without Formatting". Hotkey: `Ctrl+Shift+V`.

(Linux: Tested on Xubuntu.)

#### Mac OS X <a href="#mac-os-x" id="mac-os-x"></a>

- **Chrome**: _Edit_ menu and context menu: "Paste and Match Style". Hotkey: ⇧⌘V (`Shift+Command+V`).
- **Firefox**: There doesn't seem to be a menu item. Hotkey: ⇧⌘V (`Shift+Command+V`).
- **Thunderbird, Postbox**: _Edit_ menu and context menu: "Paste Without Formatting". Hotkey: ⇧⌘V (`Shift+Command+V`).

\
Using email signatures <a href="#sigs" id="sigs"></a>

---

Email signatures are automatically excluded from conversion. Specifically, anything after the semi-standard `'-- '` (note the trailing space) is left alone.

Note that Hotmail and Yahoo do not automatically add the `'-- '` to signatures, so you have to add it yourself.

\
Footnotes <a href="#footnotes" id="footnotes"></a>

---

Below is a copy-paste of a workaround described in the [feature request/issue](https://github.com/adam-p/markdown-here/issues/94) for adding footnotes:

I thought of a bit of a hack you can use to emulate your footnotes: put inline HTML `<sup>` tags1. What I just did there looks like this: `<sup>1</sup>`. Then you can put a numbered list2 at the bottom with the actual footnotes.

The numbered list in your original email had a larger left-side margin than mine will, but you could modify your "Primary Styling CSS" in the MDH options to and add something like `margin-left: 10em;` to the `ol` rule. But then it'd be like that for all your numbered lists.

You also have the carriage-return-ish icon in your footnotes at the bottom, but they're not links that lead back to the anchor, so... maybe you don't need them? If you want to add them by hand you can use the HTML entity3 `&crarr;`. Like so: ↵

I haven't been using the square brackets around the footnote super numbers because there's a danger of them ending up being reference-style MD links4. Like this[11](http://markdown-here.com) but not like this\[12].

Anyway, maybe this will help you and maybe it won't. It's probably more hassle than you're happy with. I'll include the raw version of this email below so that you can see it.

1. Gratuitous link to info about the `<sup>` tag: [https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup)
2. [MD cheatsheet entry for lists](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#wiki-lists)
3. [List of HTML entities](http://www.w3schools.com/tags/ref_symbols.asp)
4. [https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#links](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#links)

---

```
I thought of a bit of a hack you can use to emulate your footnotes: put inline HTML `<sup>` tags<sup>1</sup>. What I just did there looks like this: `<sup>1</sup>`. Then you can put a numbered list<sup>2</sup> at the bottom with the actual footnotes.

The numbered list in your original email had a larger left-side margin than mine will, but you could modify your "Primary Styling CSS" in the MDH options to and add something like `margin-left: 10em;` to the `ol` rule. But then it'd be like that for all your numbered lists.

You also have the carriage-return-ish icon in your footnotes at the bottom, but they're not links that lead back to the anchor, so... maybe you don't need them? If you want to add them by hand you can use the HTML entity<sup>3</sup> `&crarr;`. Like so: &crarr;

I haven't been using the square brackets around the footnote super numbers because there's a danger of them ending up being reference-style MD links<sup>4</sup>. Like this<sup>[11]</sup> but not like this<sup>[12]</sup>.

[11]: http://markdown-here.com

Anyway, maybe this will help you and maybe it won't. It's probably more hassle than you're happy with. I'll include the raw version of this email below so that you can see it.

1. Gratuitous link to info about the `<sup>` tag: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/sup
2. [MD cheatsheet entry for lists](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#wiki-lists)
3. [List of HTML entities](http://www.w3schools.com/tags/ref_symbols.asp)
4. https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#links
```

\
\
Using other TeX math formulae renderers <a href="#tex" id="tex"></a>

---

The default Google Charts service that Markdown Here uses for TeX math rendering doesn't support all math symbols (like [`\cong`](https://github.com/adam-p/markdown-here/issues/199)), and doesn't provide very crisp images. It was chosen because it was thought (by me) to be the least bad option, privacy-wise (because you're probably already using Google for your email). However, there are other possibilities, if you're willing to accept the implications.

[CodeCogs](http://www.codecogs.com) supports a wider range of symbols (I think) and provides more rendering targets. You can fool around with its [equation editor here](http://www.codecogs.com/latex/eqneditor.php). To use CodeCogs to produce PNG images, set this in Markdown Here's "TeX Mathematical Formulae Support" option:

```
<img src="https://latex.codecogs.com/png.latex?{urlmathcode}" alt="{mathcode}">
```

Using this will give you nice smooth SVG images, but note that they will get stripped out of email:

```
<img src="https://latex.codecogs.com/svg.latex?{urlmathcode}" alt="{mathcode}">
```

But please note a few important things:

- You're in charge of making sure that you're not violating [CodeCogs' terms of use](http://www.codecogs.com/pages/agreements/termsofuse.php). You should also check out [their privacy policy](http://www.codecogs.com/pages/agreements/privacy_policy.php).
- Understand that CodeCogs will be able to see all of your formulae. They can also do things map your IP address to your formulae. And then they can record the IP addresses of the people that read your email and view the formulae. And so they can draw some conclusions that someone at your IP address working with people at your friends' IP addresses.

For more discussion and technical info, see [issue #144](https://github.com/adam-p/markdown-here/issues/144).

\
Changing the Main Font (and other overall styles) <a href="#mainfont" id="mainfont"></a>

---

In the "Primary Styling CSS" section of the Markdown Here options page, there is a rule for `.markdown-here-wrapper` (that's empty by default). This rule should be used for styles that you want applied to your entire email (overridden by other styles, of course).

So, if you wanted Verdana as your default font, you could set this:

```
.markdown-here-wrapper {
  font-family: Verdana, sans;
}
```

and this (if you want to apply the new font not only to the first row of your tables):

```
table tr th, table tr td {
  font-family: Verdana, sans;
  ...
}
```

![main font example](https://f.cloud.github.com/assets/425687/588697/75922c86-c992-11e2-8071-f42f40295e3c.gif)

\
Getting fancy with inline HTML <a href="#inlinehtml" id="inlinehtml"></a>

---

Markdown (and Markdown Here) allows for inline HTML tags to be used when writing the Markdown, and having them preserved when rendering. This provides you with the ability to add more powerful styling than is possible with Markdown or email alone.

You probably don't want to use these tricks too often, since they involve a lot more (and less natural) typing than normal Markdown, but they can let you do very powerful things that you can't otherwise.

**PLEASE NOTE:** _Always test_ to your fancy styles and HTML tags by sending an email that uses them to yourself and then viewing the email. Some email clients strip out some styles, so it might look good when you send it, but not when you receive it.

#### HTML Tags <a href="#html-tags" id="html-tags"></a>

Some HTML tags that aren't available in a normal email client can be used if typed directly. For example, you can get superscripts and subscripts like this:

```
hi<sup>1</sup> low<sub>2</sub>
```

The result will look like this: hi1 low2

TODO: More examples?

#### Custom CSS classes <a href="#custom-css-classes" id="custom-css-classes"></a>

In Markdown Here's "Primary Styling CSS" you can create custom CSS classes that apply to `<span>` elements that you use inline.

Let's say you want to the background color of some text in your email to be a nice gradient from light blue to light pink and have a big horrible border. You could create a CSS rule like this:

```
.hi {
  background: linear-gradient(225deg, lightpink, lightblue);
  border: thick dotted purple;
}
```

And then use it in your email something like this:

```
Happy <span class="hi">Birthday</span> my friend!
```

(The preview of it won't show properly here, but try it out yourself in your email.)

TODO: More compelling, less ridiculous examples.

\
Cool CSS stuff <a href="#css" id="css"></a>

---

#### Different numbering for ordered lists <a href="#different-numbering-for-ordered-lists" id="different-numbering-for-ordered-lists"></a>

By defaults, ordered (aka numbered) lists use ordinary Arabic numbers (1, 2, 3, ...). But with a single CSS rule you can use Roman numerals, or Greek letters, or Thai numbers, and [lots of others](https://developer.mozilla.org/en-US/docs/Web/CSS/list-style-type):

```
ol {
  list-style-type: lower-greek;
}
```

#### Salutation Styling <a href="#salutation-styling" id="salutation-styling"></a>

If you want to style the salutation of your email differently from the rest of the email, you can add a CSS rule that applies to the very first paragraph like so:

```
.markdown-here-wrapper > p:first-of-type {
  color: red;
}
```

(Note that this will apply to the first paragraph of all MDH-rendered chunks in an email. So if you're rendering multiple selections you'll get multiple red paragraphs. For my complex CSS to fix this, check out [this SO post](https://stackoverflow.com/questions/2717480/css-selector-for-first-element-with-class/8539107#8539107).)

\
Creating more complex tables <a href="#tables" id="tables"></a>

---

There is a [feature request](https://github.com/adam-p/markdown-here/issues/176) for adding the ability to span cells across rows and columns, but it hasn't yet been implemented.

Probably the best way to do rowspan and colspan right now is to use this [online HTML table generator](http://www.tablesgenerator.com/html_tables) to create your table, and then paste it into your email (or whatever) and use MDH to render it. _Make sure_ to check the boxes for "Do not generate CSS" (because MDH provides the CSS) and "Compact mode" (to avoid MDH's multi-line HTML [problem](https://github.com/adam-p/markdown-here/issues/157)).

#### Header-less tables <a href="#header-less-tables" id="header-less-tables"></a>

See [this issue comment](https://github.com/adam-p/markdown-here/issues/266#issuecomment-85580214) for help on approximately creating a table without a header row (without using HTML).

\
Getting original Markdown from sent email <a href="#post-send-md" id="post-send-md"></a>

---

There is an outstanding [feature request](https://github.com/adam-p/markdown-here/issues/252) to be able to get the original Markdown from a sent email, but for now there's an easy trick to get it:

1. Open the message.
2. Start a forward of it.
3. Markdown Toggle.
4. The forward content will be replaced with the original Markdown.

This has been tested in Gmail and Thunderbird. If the mail client quotes the forwarded content, then it won't work.

\
Using Header Anchor Links <a href="#header-anchors" id="header-anchors"></a>

---

\[Stub. Someone (like me or Casey) should fill this in. Also, this section should probably not be at the bottom of the page -- it should probably be second or third.]
