---
title: CSS
excerpt: >-
  Variables are how programming and scripting languages represent data. A
  variable is nothing more than a label, a name assigned to a location or set of
  locations in computer memory holding an item of data.Variables appear in
  arithmetic operations and manipulation of quantities, and in string parsing.
date: '2021-11-27'
thumb_img_path: images/bash.png
thumb_img_alt: Hikers on the trail
content_img_path: images/css-a3da8bfa.jpg
content_img_alt: Hikers on the trail
seo:
  title: Hiking The Grand Canyon
  description: >-
    Css Cheat sheet
  extra:
    - name: "og:type"
      value: article
      keyName: property
    - name: "og:title"
      value: Hiking The Grand Canyon
      keyName: property
    - name: "og:description"
      value: >-
        The Grand Canyon is a steep-sided canyon carved by the Colorado River in
        Arizona
      keyName: property
    - name: "og:image"
      value: images/8.jpg
      keyName: property
      relativeUrl: true
    - name: "twitter:card"
      value: summary_large_image
    - name: "twitter:title"
      value: Hiking The Grand Canyon
    - name: "twitter:description"
      value: >-
        The Grand Canyon is a steep-sided canyon carved by the Colorado River in
        Arizona
    - name: "twitter:image"
      value: images/8.jpg
      relativeUrl: true
template: post
subtitle: Cheat Sheet
---



# CSS Cheat Sheet



> ## Excerpt
> CSS Cheat Sheet - A reference for CSS goodness.

---
### A reference for CSS goodness.

___

-   📚 Top Articles
-   🛠 Resources & Tools
-   🔍 Dev, Design & More Topics
-   🙏 Community Content

### Selectors

Type Selector

`h1, h2 ,h3 {}`

Adjacent Sibling Selector

`h1 + p {}`

Child Selector

`ul > li {}`

General Sibling Selector

`h1 ~ p {}`

Descendant Selector

`p a {}`

Attribute Selector

`div[attribute="SomeValue"] {}`

### Pseudo Selectors & Elements

Mouse Over Selector

`a:hover {}`

Active Link Selector

`a:active {}`

Focus Selector

`input:focus {}`

Visited Links Selector

`a:visited {}`

Link Selector

`.class:link {}`

Checked elements selector

`input:checked {}`

Disabled elements selector

`input:disabled {}`

Enabled elements selector

`input:enabled {}`

Not a Specified Element Selector

`:not(p) {}`

First Line Selector

`p::first-line {}`

First Letter Selector

`p::first-letter {}`

First Child Selector

`p:first-child {}`

Last Child Selector

`p:last-child {}`

Only Child Selector

`p:only-child {}`

:nth-child Selector

`p:nth-child() {}`

First Element of its Parent Selector

`p:first-of-type {}`

Elements that have no Children Selector

`p:empty {}`

Before Element

`.class::before {}`

After Element

`.class::after {}`

### Text Styling

Font style

`font-style: normal | italic | oblique`

Font Variant

`font-variant: normal | small-caps`

Font Weight

`font-weight: normal | bold | bolder | lighter | 100 - 900`

Vertical Alignment

`vertical-align: baseline | 10px | sub | super | top | text-top | middle | bottom | text-bottom | initial`

Text Transform

`text-transform: capitalise | lowercase | uppercase`

Font Size

`font-size: 12px | 0.8em | 80%`

Space Between Characters

`letter-spacing: normal | 4px`

Line Height

`line-height: normal | 3em | 34%`

Horizontal Alignment

`text-align: left | right | center | justify`

Text Align Last

`text-align-last: auto | left | right | center | justify | start | end | initial | inherit`

Text Decoration

`text-decoration: none | underline | overline | line-through`

Indent First Line

`text-indent: 25px`

Font Family

`font-family: 'Open Sans', sans-serif`

Text Justify

`text-justify: auto | inter-word | inter-character | none | initial | inherit`

Text Overflow

`text-overflow: clip | ellipsis | string | initial | inherit`

Text Shadow

`text-shadow: h-shadow v-shadow blur-radius color | none | initial | inherit`

### Position

Position

`position: static | relative | absolute | fixed | sticky`

Position Properties

`top | right | bottom | left`

Float Element

`float: left | right | none`

Clear Floating Elements

`clear: none | left | right | both`

Z Index

`z-index: 3 | auto | inherit`

### Background

Background Image

`background-image: url()`

Background Repeat

`background-repeat: repeat-x | repeat-y | repeat | space | round | no-repeat`

Background Attachment

`background-attachment: scroll | fixed | local | initial | inherit`

Background Color

`background-color: #2AA9E0`

Background Position

`background-position: top | right | bottom | left | center`

### Box Properties

Box Sizing

`box-sizing: border-box | content-box`

Margin

`margin: 2px 4px 6px 8px | 0 auto`

Padding

`padding: 2px 4px 6px 8px`

Border Color

`border-color: #2AA9E0`

Border Style

`border-style: none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset`

Border Width

`border-width: 10px`

### List Styling

List Type

`list-style-type: disc | circle | square | none`

List Position

`list-style-position: inside | outside`

List Image

`list-style-image: url()`

### Flexbox

Flex Direction

`flex-direction: row | row-reverse | column | column-reverse`

Flex Wrap

`flex-wrap: nowrap | wrap | wrap-reverse`

Justify Content

`justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly`

Align Items

`align-items: flex-start | flex-end | center | baseline | stretch`

Align Content

`align-content: flex-start | flex-end | center | space-between | space-around | stretch`

Flex Shrink

`flex-shrink: 1`

Flex Basis

`flex-basis: 3px | auto`

Align Self

`align-self: auto | flex-start | flex-end | center | baseline | stretch`

### CSS Grid

Grid Template Columns

`grid-template-columns: 40px 50px auto 50px 40px`

Grid Template Rows

`grid-template-rows: 25% 100px auto`

Grid Template Areas

`grid-template-areas: "a b c" | none`

Grid Template

`grid-template: "a a a" 20% "b b b" auto | 100px 1fr / 50px 1fr`

Grid Column Gap

`grid-column-gap: 10px`

Grid Row Gap

`grid-row-gap: 10px`

Justify Items

`justify-items: start | end | center | stretch`

Align Items

`align-items: start | end | center | stretch`

Justify Content

`justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly`

Align Content

`align-content: flex-start | flex-end | center | space-between | space-around | stretch`

Grid Auto Columns

`grid-auto-columns: 100px | max-content | min-content`

Grid Auto Rows

`grid-auto-rows: 100px | max-content | min-content`

Grid Auto Flow

`grid-auto-flow: row | column | row dense | column dense`

Grid Column Start

`grid-column-start: 2 | areaname | span 2 | span areaname | auto`

Grid Column End

`grid-column-end: 2 | areaname | span 2 | span areaname | auto`

Grid Row Start

`grid-row-start: 2 | areaname | span 2 | span areaname | auto`

Grid Row End

`grid-row-end: 2 | areaname | span 2 | span areaname | auto`

Grid Column

`grid-column: 3 / span 2`

Grid Row

`grid-row: 3 / span 2`

Justify Self

`justify-self: start | end | center | stretch`

Align Self

`align-self: start | end | center | stretch`

### Dynamic Content

CSS Variable

`--variable-name: value`

Variable Usage

`var(--variable-name)`

Counter Reset

`counter-reset: name-of-counter`

Counter Increment

`counter-increment: name-of-counter`

Counter Dynamic Value

`content: counter(name-of-counter)`

Attribute Dynamic Value

`content: attr(name-of-attribute)`


