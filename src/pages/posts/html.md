---
title: HTML Cheat Sheet
subtitle: >-
  Html cheat sheet is a collection of html tags and attributes
excerpt: >-
  Html cheat sheet is a collection of html tags and attributes.
date: "2017-03-26"
thumb_img_path: images/1.jpg
thumb_img_alt: html
seo:
  title: HTML Cheat Sheet
  description: Html cheat sheet is a collection of html tags and attributes.
  extra:
    - name: "og:type"
      value: article
      keyName: property
    - name: "og:title"
      value: HTML Cheat Sheet
      keyName: property
    - name: "og:description"
      value: Html cheat sheet is a collection of html tags and attributes.
      keyName: property
    - name: "og:image"
      value: images/1.jpg
      keyName: property
      relativeUrl: true
    - name: "twitter:card"
      value: summary_large_image
    - name: "twitter:title"
      value: How To Choose An Interior Designer
    - name: "twitter:description"
      value: Html cheat sheet is a collection of html tags and attributes.
    - name: "twitter:image"
      value: images/1.jpg
      relativeUrl: true
template: post
---

## Html

Main root 
<html> … </html>
The HTML <html> element represents the root (top-level element) of an HTML document, so it 
is also referred to as the root element. All other elements must be descendants of this element. 
Example: 
<!DOCTYPE html>
<html lang="en">
 <head>...</head>
 <body>...</body>
</html>
Document metadata
<head> … </head>
The HTML <head> element contains machine-readable information (metadata) about the 
document, like its title, scripts, and style sheets. 
<link>
The HTML External Resource Link element (<link>) specifies relationships between the current 
document and an external resource. This element is most commonly used to link to stylesheets, 
but is also used to establish site icons (both "favicon" style icons and icons for the home screen 
and apps on mobile devices) among other things. 
<meta>
The HTML <meta> element represents metadata that cannot be represented by other HTML 
meta-related elements, like <base>, <link>, <script>, <style> or <title> 
<style> … </style>
The HTML <style> element contains style information for a document, or part of a document. 
<title> … </title>
The HTML Title element (<title>) defines the document's title that is shown in a browser's title 
bar or a page's tab. 
Example: 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  2
<!DOCTYPE html>
<html lang="en">
 <head>...</head>
 <body>...</body>
</html>
Sectioning root 
<body> … </body>
The HTML <body> Element represents the content of an HTML document. There can be only 
one <body> element in a document. 
Example: 
<html>
 <head>
 <title>Document title</title>
 </head>
 <body>
 <p>This is a paragraph</p>
 </body>
</html>
Content sectioning 
<address> … </address>
The HTML <address> element indicates that the enclosed HTML provides contact information 
for a person or people, or for an organization. 
<article> … </article>
The HTML <article> element represents a self-contained composition in a document, page, 
application, or site, which is intended to be independently distributable or reusable (e.g., in 
syndication). 
<aside> … </aside>
The HTML <aside> element represents a portion of a document whose content is only indirectly 
related to the document's main content. 
<footer> … </footer>
The HTML <footer> element represents a footer for its nearest sectioning content or sectioning 
root element. A footer typically contains information about the author of the section, copyright 
data or links to related documents. 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  3
<header> … </header>
The HTML <header> element represents introductory content, typically a group of introductory 
or navigational aids. It may contain some heading elements but also a logo, a search form, an 
author name, and other elements. 
<h1> to <h6> … </h6>
The HTML <h1>–<h6> elements represent six levels of section headings. <h1> is the highest 
section level and <h6> is the lowest. 
<main> … </main>
The HTML <main> element represents the dominant content of the <body> of a document. The 
main content area consists of content that is directly related to or expands upon the central 
topic of a document, or the central functionality of an application. 
<nav> … </nav>
The HTML <nav> element represents a section of a page whose purpose is to provide 
navigation links, either within the current document or to other documents. Common examples 
of navigation sections are menus, tables of contents, and indexes. 
<section> … </section>
The HTML <section> element represents a standalone section — which doesn't have a more 
specific semantic element to represent it — contained within an HTML document. 
Example: 
<address>
 <a href="mailto:jim@rock.com">jim@rock.com</a><br>
 <a href="tel:+13115552368">(311) 555-2368</a>
</address>
Text content 
<blockquote> … </blockquote>
The HTML <blockquote> Element (or HTML Block Quotation Element) indicates that the 
enclosed text is an extended quotation. Usually, this is rendered visually by indentation (see 
Notes for how to change it). A URL for the source of the quotation may be given using the cite 
attribute, while a text representation of the source can be given using the <cite> element. 
<dd> … </dd>
The HTML <dd> element provides the description, definition, or value for the preceding term 
(<dt>) in a description list (<dl>). 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  4
<div> … </div>
The HTML Content Division element (<div>) is the generic container for flow content. It has no 
effect on the content or layout until styled using CSS. 
<dl> … </dl>
The HTML <dl> element represents a description list. The element encloses a list of groups of 
terms (specified using the <dt> element) and descriptions (provided by <dd> elements). 
Common uses for this element are to implement a glossary or to display metadata (a list of 
key-value pairs). 
<dt> … </dt>
The HTML <dt> element specifies a term in a description or definition list, and as such must be 
used inside a <dl> element. 
<figcaption> … </figcaption>
The HTML <figcaption> or Figure Caption element represents a caption or legend describing 
the rest of the contents of its parent <figure> element.
<figure> … </figure>
The HTML <figure> (Figure With Optional Caption) element represents self-contained content, 
potentially with an optional caption, which is specified using the (<figcaption>) element. 
<hr>
The HTML <hr> element represents a thematic break between paragraph-level elements: for 
example, a change of scene in a story, or a shift of topic within a section. 
<li> … </li>
The HTML <li> element is used to represent an item in a list. 
<ol> … </ol>
The HTML <ol> element represents an ordered list of items, typically rendered as a numbered 
list. 
<p> … </p>
The HTML <p> element represents a paragraph. 
<pre> … </pre>
The HTML <pre> element represents preformatted text which is to be presented exactly as 
written in the HTML file. 
<ul> … </ul>
The HTML <ul> element represents an unordered list of items, typically rendered as a bulleted 
list. 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  5
Examples: 
<dl>
 <dt>Denim (semigloss finish)</dt>
 <dd>Ceiling</dd>

 <dt>Denim (eggshell finish)</dt>
 <dt>Evening Sky (eggshell finish)</dt>
 <dd>Layered on the walls</dd>
</dl>
<figure>
 <img src="/media/examples/elephant-660-480.jpg"
 alt="Elephant at sunset">
 <figcaption>An elephant at sunset</figcaption>
</figure>
<ol>
 <li>Mix flour, baking powder, sugar, and salt.</li>
 <li>In another bowl, mix eggs, milk, and oil.</li>
 <li>Stir both mixtures together.</li>
 <li>Fill muffin tray 3/4 full.</li>
 <li>Bake for 20 minutes.</li>
</ol>
Inline text semantics 
<a> … </a>
The HTML <a> element (or anchor element), with its href attribute, creates a hyperlink to web 
pages, files, email addresses, locations in the same page, or anything else a URL can address. 
<abbr> … </abbr>
The HTML Abbreviation element (<abbr>) represents an abbreviation or acronym; the optional 
title attribute can provide an expansion or description for the abbreviation. 
<br>
The HTML <br> element produces a line break in text (carriage-return). It is useful for writing a 
poem or an address, where the division of lines is significant. 
<cite> … </cite>
The HTML Citation element (<cite>) is used to describe a reference to a cited creative work, and 
must include the title of that work. 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  6
<code> … </code>
The HTML <code> element displays its contents styled in a fashion intended to indicate that the 
text is a short fragment of computer code. 
<em> … </em>
The HTML <em> element marks text that has stress emphasis. The <em> element can be 
nested, with each level of nesting indicating a greater degree of emphasis. 
<mark> … </mark>
The HTML Mark Text element (<mark>) represents text which is marked or highlighted for 
reference or notation purposes, due to the marked passage's relevance or importance in the 
enclosing context. 
<small> … </small>
The HTML <small> element represents side-comments and small print, like copyright and legal 
text, independent of its styled presentation. By default, it renders text within it one font-size 
small, such as from small to x-small. 
<span> … </span>
The HTML <span> element is a generic inline container for phrasing content, which does not 
inherently represent anything. It can be used to group elements for styling purposes (using the 
class or id attributes), or because they share attribute values, such as lang. 
<strong> … </strong>
The HTML Strong Importance Element (<strong>) indicates that its contents have strong 
importance, seriousness, or urgency. Browsers typically render the contents in bold type. 
<time> … </time>
The HTML <time> element represents a specific period in time. 
Examples: 
<blockquote>
 <p>It was a bright cold day in April, and the clocks were striking
thirteen.</p>
 <footer>
 First sentence in <cite><a
href="http://www.george-orwell.org/1984/0.html"><em>Nineteen
Eighty-Four</em></a></cite> by George Orwell (Part 1, Chapter 1).
 </footer>
</blockquote>
<p>You can use <abbr title="Cascading Style Sheets">CSS</abbr> to style your
<abbr title="HyperText Markup Language">HTML</abbr>.</p>
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  7
Image and multimedia 
<audio> … </audio>
The HTML <audio> element is used to embed sound content in documents. It may contain one 
or more audio sources, represented using the src attribute or the <source> element: the 
browser will choose the most suitable one. It can also be the destination for streamed media, 
using a MediaStream. 
<img>
The HTML <img> element embeds an image into the document. 
<track>
The HTML <track> element is used as a child of the media elements <audio> and <video>. It 
lets you specify timed text tracks (or time-based data), for example to automatically handle 
subtitles. The tracks are formatted in WebVTT format (.vtt files) — Web Video Text Tracks or 
Timed Text Markup Language (TTML). 
<video> … </video>
The HTML Video element (<video>) embeds a media player which supports video playback into 
the document. You can use <video> for audio content as well, but the <audio> element may 
provide a more appropriate user experience. 
Examples: 
<img class="fit-picture"
 src="/media/examples/grapefruit-slice-332-332.jpg"
 alt="Grapefruit slice atop a pile of other slices">
<figure>
 <figcaption>Listen to the T-Rex:</figcaption>
 <audio
 controls
 src="/media/examples/t-rex-roar.mp3">
 Your browser does not support the
 <code>audio</code> element.
 </audio>
</figure>
<video controls width="250"
 src="/media/examples/friday.mp4">
 <track default kind="captions"
 srclang="en"
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  8
 src="/media/examples/friday.vtt"/>
 Sorry, your browser doesn't support embedded videos.
</video>
Scripting 
<script> … </script> 
The HTML <script> element is used to embed or reference executable code; this is typically 
used to embed or refer to JavaScript code. 
Example: 
<!-- HTML4 -->
<script type="text/javascript" src="javascript.js"></script>
<!-- HTML5 -->
<script src="javascript.js"></script>
Demarcating edits 
<del> … </del>
The HTML <del> element represents a range of text that has been deleted from a document. 
<ins> … </ins>
The HTML <ins> element represents a range of text that has been added to a document. 
Example: 
<p>“You're late!”</p>
<del>
 <p>“I apologize for the delay.”</p>
</del>
<ins cite="../howtobeawizard.html" datetime="2018-05">
 <p>“A wizard is never late …”</p>
</ins>
Table content 
<caption> … </caption>
The HTML Table Caption element (<caption>) specifies the caption (or title) of a table, and if 
used is always the first child of a <table>. 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  9
<table> … </table>
The HTML <table> element represents tabular data — that is, information presented in a 
two-dimensional table comprised of rows and columns of cells containing data. 
<tbody> … </tbody>
The HTML Table Body element (<tbody>) encapsulates a set of table rows (<tr> elements), 
indicating that they comprise the body of the table (<table>). 
<td> … </td>
The HTML <td> element defines a cell of a table that contains data. It participates in the table 
model. 
<tfoot> … </tfoot>
The HTML <tfoot> element defines a set of rows summarizing the columns of the table. 
<th> … </th>
The HTML <th> element defines a cell as header of a group of table cells. The exact nature of 
this group is defined by the scope and headers attributes. 
<thead> … </thead>
The HTML <thead> element defines a set of rows defining the head of the columns of the table. 
<tr> … </tr>
The HTML <tr> element defines a row of cells in a table. The row's cells can then be established 
using a mix of <td> (data cell) and <th> (header cell) elements. 
Example: 
<table>
 <thead>
 <tr>
 <th colspan="2">The table header</th>
 </tr>
 </thead>
 <tbody>
 <tr>
 <td>The table body</td>
 <td>with two columns</td>
 </tr>
 </tbody>
</table>
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  10
Forms 
<button> … </button>
The HTML <button> element represents a clickable button, which can be used in forms or 
anywhere in a document that needs simple, standard button functionality. 
<datalist> … </datalist>
The HTML <datalist> element contains a set of <option> elements that represent the values 
available for other controls. 
<fieldset> … </fieldset>
The HTML <fieldset> element is used to group several controls as well as labels (<label>) 
within a web form. 
<form> … </form>
The HTML <form> element represents a document section that contains interactive controls for 
submitting information to a web server. 
<input>
The HTML <input> element is used to create interactive controls for web-based forms in order 
to accept data from the user; a wide variety of types of input data and control widgets are 
available, depending on the device and user agent. 
<label> … </label>
The HTML <label> element represents a caption for an item in a user interface. 
<legend> … </legend>
The HTML <legend> element represents a caption for the content of its parent <fieldset>. 
<optgroup> … </optgroup>
The HTML <optgroup> element creates a grouping of options within a <select> element. 
<option> … </option>
The HTML <option> element is used to define an item contained in a <select>, an <optgroup>, 
or a <datalist> element. As such, <option> can represent menu items in popups and other lists 
of items in an HTML document. 
<progress> … </progress>
The HTML <progress> element displays an indicator showing the completion progress of a 
task, typically displayed as a progress bar. 
WebsiteSetup.org - Beginner’s HTML Cheat Sheet  11
<select> … </select>
The HTML <select> element represents a control that provides a menu of options 
<textarea> … </textarea>
The HTML <textarea> element represents a multi-line plain-text editing control, useful when 
you want to allow users to enter a sizeable amount of free-form text, for example a comment 
on a review or feedback form. 
Example: 
<form action="" method="get" class="form-example">
 <div class="form-example">
 <label for="name">Enter your name: </label>
 <input type="text" name="name" id="name" required>
 </div>
 <div class="form-example">
 <label for="email">Enter your email: </label>
 <input type="email" name="email" id="email" required>
 </div>
 <div class="form-example">
 <input type="submit" value="Subscribe!">
 </div>
</form>
Interactive elements 
<details> … </details>
The HTML Details Element (<details>) creates a disclosure widget in which information is 
visible only when the widget is toggled into an "open" state. 
<summary> … </summary>
The HTML Disclosure Summary element (<summary>) element specifies a summary, caption, or 
legend for a <details> element's disclosure box. 
Example: 
<details>
 <summary>Details</summary>
 Something small enough to escape casual notice.
</details> 


---

```html
<!DOCTYPE html>
<!-- Tells the browser that HTML5 version of HTML to be recognized by the browser -->
<html lang="en"></html>
<!-- The HTML lang attribute is used to identify the language of text content on the web. This information helps search engines return language specific results, -->
<head></head>
<!-- Contains Information specific to the page like title, styles and scripts -->
<title></title>
<!-- Title for the page that shows up in the browser title bar -->
<body></body>
<!-- Content that the user will see -->

<!-- Document Information -->

<base />
<!-- Usefull for specifying relative links in a document -->
<style></style>
<!-- Contains styles for the html document -->
<meta />
<!-- Contains additional information about the page, author, page description and other hidden page info -->
<script></script>
<!-- Contains all scripts internal or external -->
<link />
<!-- Used to create relationships with external pages and stylesheets -->

<!-- Document Structure -->

<h1></h1>
...
<h6></h6>
<!-- All six levels of heading with 1 being the most promiment and 6 being the least prominent -->
<p></p>
<!-- Used to organize paragraph text -->
<div></div>
<!-- A generic container used to denote a page section -->
<span></span>
<!-- Inline section or block container used for creating inline style elements -->
<br />
<!-- Creates a line-break -->
<hr />
<!-- Creates a sectional break into HTML -->

<!-- Text Formatting -->

<strong></strong> and <b></b>
<!-- Makes text contained in the tag as bold -->
<em></em> and <i></i>
<!-- Alternative way to make the text contained in the tag as italic -->
<strike></strike>
<!-- Creates a strike through the text element -->
<pre></pre>
<!-- Preformatted monospace text block with some spacing intact -->
<blockquote></blockquote>
<!-- Contains long paragraphs of quotations often cited -->
<abbr></abbr>
<!-- Contains abbreviations while also making the full form avaialable -->
<address></address>
<!-- Used to display contact information -->
<code></code>
<!-- Used to display inline code snippets -->
<q></q>
<!-- Defines a short inline quotation -->
<sub></sub>
<!-- 	Defines subscripted text -->
<sup></sup>
<!-- Defines superscripted text -->
<kbd></kbd>
<!-- Specifies text as keyboard input -->
<small></small>
<!-- Specifies small text -->

<!-- Links Formatting -->

<a href="url"></a>
<!-- Used to link to external or internal pages of a wbesite -->
<a href="mailto:email@example.com"></a>
<!-- Used to link to an email address -->
<a href="name"></a>
<!-- Used to link to a document element -->
<a href="#name"></a>
<!-- Used to link to specific div element -->
<a href="tel://####-####-##"></a>
<!-- Used to display phone numbers and make them clickable -->

<!-- Image Formatting -->

<img src="url" alt="text" />
<!-- Used to display images in a webpage where src="url" contains the link to the image source and alt="" contains an alternative text to display when the image is not displayed -->

<!-- List Formatting -->

<ol></ol>
<!-- Used to create ordered lists with numbers in the items -->
<ul></ul>
<!-- Used to display unordered lists with numbers in the items -->
<li></li>
<!-- Contains list items inside ordered and unordered lists -->
<dl></dl>
<!-- Contains list item definitions -->
<dt></dt>
<!-- Definition of single term inline with body content -->
<dd></dd>
<!-- The descrpition of the defined term -->

<!-- Forms Formatting and Attributes -->

<form action="url"></form>
<!-- Form element creates a form and action="" specifies where the data is to be sent to when the visitor submits the form -->

<!-- Supported attributes -->
method="somefunction()"
<!-- Contains the type of request (GET, POST... etc) which dictates how to send the data of the form -->
enctype=""
<!-- Dictates how the data is to be encoded when the data is sent to the web server. -->
autocomplete=""
<!-- Specifies if the autocomplete functionality is enabled or not -->
novalidate
<!-- Dictates if the form will be validated or not -->
accept-charset=""
<!-- Identifies the character encoding upon form submission -->
target=""
<!-- Tell where to display the information upon form submission. Possible values: '_blank', '_self', '_parent', '_top' -->

<fieldset disabled="disabled"></fieldset>
<!-- Identifies the group of all fields in the form -->
<label for=""></label>
<!-- A simple field label telling the user what to type in the field -->
<legend></legend>
<!-- The form legend acts as a caption for the fieldset element -->

<input type="text/email/number/color/date" />
<!-- Input is the input field where the user can input various types of data -->

<!-- Supported attributes -->
name=""
<!-- Describes the name of the form -->
width=""
<!-- Specifies the width of an input field -->
value=""
<!-- Describes the value of the input information field -->
size=""
<!-- Specifies the input element width in characters -->
maxlength=""
<!-- Specifies the maximum input character numbers -->
required=""
<!-- Specifies if the input field is required to fill in before submitting the form -->
step=""
<!-- Identifies the legal number intervals of the input field -->

<textarea name="" id="" cols="30" rows="10">
      <!-- Specifies a large input text field for longer messages -->
</textarea>

<select name=""></select>
<!-- Describes a dropdown box for users to select from variety of choices -->

<!-- Supported attributes -->
name=""
<!-- The name for a dropdown combination box -->
size=""
<!-- Specifies the number of available options -->
multiple
<!-- Allows for multiple option selections -->
required
<!-- Requires that a value is selected before submitting the form -->
autofocus
<!-- Specifies that the dropdown automatically comes to focus once the page loads -->
<optgroup></optgroup>
<!-- Specifies the entire grouping of available options -->
<option value=""></option>
<!-- Defines one of the avaialble option from the dropdown list -->
<button></button>
<!-- A clickable button to submit the form -->

<!-- Tables Formatting -->

<table></table>
<!-- Defines and contains all table related content -->
<caption></caption>
<!-- A description of what table is and what it contains -->
<thead></thead>
<!-- The table headers contain the type of information defined in each column underneath -->
<tbody></tbody>
<!-- Contains the tables data or information -->
<tfoot></tfoot>
<!-- Defines table footer -->
<tr></tr>
<!-- Contains the information to be included in a table row -->
<th></th>
<!-- Contains the information to be included in a single table header -->
<td></td>
<!-- Contains actual information in a table cell -->
<colgroup></colgroup>
<!-- Groups a single or multiple columns for formatting purposes -->
<col />
<!-- Defines a single column of information inside a table -->

<!-- Objects and iFrames -->

<object data=""></object>
<!-- Describes and embed file type including audio, video, PDF's, images -->

<!-- Supported attributes -->
type=""
<!-- Describes the type of media embedded -->
height=""
<!-- Describes the height of the object in pixels -->
width=""
<!-- Describes the width of the object in pixels -->
usemap=""
<!-- This is the name of the client-side image map in the object -->

<iframe src="" frameborder="0"></iframe>
<!-- Contains an inline frame that allows to embed external information -->
<embed src="" type="" />
<!-- Acts as a container for external application or plug-in -->
src=""
<!-- The source of the external file you're embedding -->
width=""
<!-- Describes the width of the iframe in pixels -->

<!-- HTML5 New Tags -->

<header></header>
<!-- Defines the header block for a document or a section -->
<footer></footer>
<!-- Defines the footer block for a document or a section -->
<main></main>
<!-- Describes the main content of a document -->
<article></article>
<!-- Identifies an article inside a document -->
<aside></aside>
<!-- Specifies content contained in a document sidebar -->
<section></section>
<!-- Defines a section of a document -->
<details></details>
<!-- Describes additonal information that user can view or hide -->
<dialog></dialog>
<!-- A dialog box or a window -->
<figure></figure>
<!-- An independent content block featuring images, diagrams or illustrations -->
<figcaption></figcaption>
<!-- Caption that describe a figure -->
<mark></mark>
<!-- Displays a portion of highlighted text with in a page content -->
<nav></nav>
<!-- Navigation links for the user in a document -->
<menuitem></menuitem>
<!-- The specific menu item that a usrr can raise from a pop up menu -->
<meter></meter>
<!-- Describes the scalar measurement with in a known array -->
<progress></progress>
<!-- Displays the progress of a task usually a progress bar -->
<rp></rp>
<!-- Describes text within the browsers that do not support ruby notations -->
<rt></rt>
<!-- Displays east asian typography character details -->
<ruby></ruby>
<!-- Describes annotations for east asian typography -->
<summary></summary>
<!-- Contains a visible heading for details element -->
<bdi></bdi>
<!-- Helps you format parts of text in a different direction than other text -->
<time></time>
<!-- Identifies the time and date -->
<wbr />
<!-- A line break within the content -->

<!-- Some other useful tags -->

<canvas></canvas>
<!-- Allows to draw 2D shapes on the web page with the help of javascript -->
<keygen>
  <!-- Represents a control for generating a public-private key pair -->
  <map></map>
  <!-- Specifies an image map -->

  <!-- Collective Character Obejcts -->

  &#34; &quot; Quotation Marks - " &#38; &amp; Ampersand - & &#60; &lt; Less
  than sign - < &#62; &gt; Greater than sign - > &#160; &nbsp; Non-breaking
  space &#169; &copy; Copyright Symbol - © &#64; &Uuml; @ symbol - @ &#149;
  &ouml; Small bullet - . &#153; &ucirc; Trademark Symbol - ™
</keygen>
```

---

### Examples:

```html

<!--
HTML stands for HyperText Markup Language.
It is a language which allows us to write pages for the world wide web.
It is a markup language, it enables us to write webpages using code to indicate
how text and data should be displayed.  In fact, html files are simple text
files.
What is this markup? It is a method of organising the page's data by
surrounding it with opening tags and closing tags.  This markup serves to give
significance to the text that it encloses.  Like other computer languages, HTML
has many versions. Here we will talk about HTML5.
**NOTE :**  You can test the different tags and elements as you progress through
the tutorial on a site like [codepen](http://codepen.io/pen/) in order to see
their effects, understand how they work and familiarise yourself with the
language.  This article is concerned principally with HTML syntax and some
useful tips.
-->



<!-- Comments are enclosed like this line! -->

<!--
	Comments
	can
	span
	multiple
	lines!
-->




<!doctype html>
	<html>
		<head>
			<title>My Site</title>
		</head>
		<body>
			<h1>Hello, world!</h1>
			<a href="http://codepen.io/anon/pen/xwjLbZ">
				Come look at what this shows
			</a>
			<p>This is a paragraph.</p>
			<p>This is another paragraph.</p>
			<ul>
				<li>This is an item in a non-enumerated list (bullet list)</li>
				<li>This is another item</li>
				<li>And this is the last item on the list</li>
			</ul>
		</body>
	</html>

<!--
	An HTML file always starts by indicating to the browser that the page is HTML.
-->
<!doctype html>

<!-- After this, it starts by opening an <html> tag. -->
<html>

<!-- that will be closed at the end of the file with </html>. -->
</html>

<!-- Nothing should appear after this final tag. -->

<!-- Inside (between the opening and closing tags <html></html>), we find: -->

<!-- A header defined by <head> (it must be closed with </head>). -->
<!--
	The header contains some description and additional information which are not
	displayed; this is metadata.
-->

<head>
	<!--
		The tag <title> indicates to the browser the title to show in browser
		window's title bar and tab name.
	-->
	<title>My Site</title>
</head>

<!-- After the <head> section, we find the tag - <body> -->
<!-- Until this point, nothing described will show up in the browser window. -->
<!-- We must fill the body with the content to be displayed. -->

<body>
	<!-- The h1 tag creates a title. -->
	<h1>Hello, world!</h1>
	<!--
		There are also subtitles to <h1> from the most important (h2) to the most
		precise (h6).
	-->

	<!-- a hyperlink to the url given by the attribute href="" -->
	<a href="http://codepen.io/anon/pen/xwjLbZ">
		Come look at what this shows
	</a>

	<!-- The tag <p> lets us include text in the html page. -->
	<p>This is a paragraph.</p>
	<p>This is another paragraph.</p>

	<!-- The tag <ul> creates a bullet list. -->
	<!--
		To have a numbered list instead we would use <ol> giving 1. for the first
		element, 2. for the second, etc.
	-->
	<ul>
		<li>This is an item in a non-enumerated list (bullet list)</li>
		<li>This is another item</li>
		<li>And this is the last item on the list</li>
	</ul>
</body>

<!-- And that's it, creating an HTML file can be simple. -->

<!-- But it is possible to add many additional types of HTML tags. -->

<!-- The <img /> tag is used to insert an image. -->
<!--
	The source of the image is indicated using the attribute src=""
	The source can be an URL or even path to a file on your computer.
-->
<img src="http://i.imgur.com/XWG0O.gif"/>

<!-- It is also possible to create a table. -->

<!-- We open a <table> element. -->
<table>

	<!-- <tr> allows us to create a row. -->
	<tr>

		<!-- <th> allows us to give a title to a table column. -->
		<th>First Header</th>
		<th>Second Header</th>
	</tr>

	<tr>

		<!-- <td> allows us to create a table cell. -->
		<td>first row, first column</td>
		<td>first row, second column</td>
	</tr>

	<tr>
		<td>second row, first column</td>
		<td>second row, second column</td>
	</tr>
</table>
</body>
</html>


```
