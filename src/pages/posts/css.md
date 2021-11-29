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



Simple:

---

### Example

```
#!/usr/bin/env bash

NAME="John"
echo "Hello $NAME!"
```

### Variables

```
NAME="John"
echo $NAME
echo "$NAME"
echo "${NAME}!"
```

### String quotes

```
NAME="John"
echo "Hi $NAME"
echo 'Hi $NAME'
```

### Conditional execution

```
git commit && git push
git commit || echo "Commit failed"
```

### Functions

```
get_name() {
  echo "John"
}

echo "You are $(get_name)"
```

See: [Functions](https://devhints.io/bash#functions)

### Conditionals

```
if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
fi
```

See: [Conditionals](https://devhints.io/bash#conditionals)

### Brace expansion

```
echo {A,B}.js
```

Expression

Description

`{A,B}`

Same as `A B`

`{A,B}.js`

Same as `A.js B.js`

`{1..5}`

Same as `1 2 3 4 5`

See: [Brace expansion](http://wiki.bash-hackers.org/syntax/expansion/brace)

## [#](https://devhints.io/bash#parameter-expansions)Parameter expansions

### Basics

```
name="John"
echo ${name}
echo ${name/J/j}
echo ${name:0:2}
echo ${name::2}
echo ${name::-1}
echo ${name:(-1)}
echo ${name:(-2):1}
echo ${food:-Cake}
```

```
length=2
echo ${name:0:length}
```

See: [Parameter expansion](http://wiki.bash-hackers.org/syntax/pe)

```
STR="/path/to/foo.cpp"
echo ${STR%.cpp}
echo ${STR%.cpp}.o
echo ${STR%/*}

echo ${STR##*.}
echo ${STR##*/}

echo ${STR#*/}
echo ${STR##*/}

echo ${STR/foo/bar}
```

```
STR="Hello world"
echo ${STR:6:5}
echo ${STR: -5:5}
```

```
SRC="/path/to/foo.cpp"
BASE=${SRC##*/}
DIR=${SRC%$BASE}
```

### Substitution

Code

Description

`${FOO%suffix}`

Remove suffix

`${FOO#prefix}`

Remove prefix

`${FOO%%suffix}`

Remove long suffix

`${FOO##prefix}`

Remove long prefix

`${FOO/from/to}`

Replace first match

`${FOO//from/to}`

Replace all

`${FOO/%from/to}`

Replace suffix

`${FOO/#from/to}`

Replace prefix

```
: '
This is a
multi line
comment
'
```

### Substrings

Expression

Description

`${FOO:0:3}`

Substring _(position, length)_

`${FOO:(-3):3}`

Substring from the right

### Length

Expression

Description

`${#FOO}`

Length of `$FOO`

### Manipulation

```
STR="HELLO WORLD!"
echo ${STR,}
echo ${STR,,}

STR="hello world!"
echo ${STR^}
echo ${STR^^}
```

### Default values

Expression

Description

`${FOO:-val}`

`$FOO`, or `val` if unset (or null)

`${FOO:=val}`

Set `$FOO` to `val` if unset (or null)

`${FOO:+val}`

`val` if `$FOO` is set (and not null)

`${FOO:?message}`

Show error message and exit if `$FOO` is unset (or null)

Omitting the `:` removes the (non)nullity checks, e.g. `${FOO-val}` expands to `val` if unset otherwise `$FOO`.

## [#](https://devhints.io/bash#loops)Loops

### Basic for loop

```
for i in /etc/rc.*; do
  echo $i
done
```

### C-like for loop

```
for ((i = 0 ; i < 100 ; i++)); do
  echo $i
done
```

### Ranges

```
for i in {1..5}; do
    echo "Welcome $i"
done
```

#### With step size

```
for i in {5..50..5}; do
    echo "Welcome $i"
done
```

### Reading lines

```
cat file.txt | while read line; do
  echo $line
done
```

## [#](https://devhints.io/bash#functions)Functions

### Defining functions

```
myfunc() {
    echo "hello $1"
}
```

```

function myfunc() {
    echo "hello $1"
}
```

```
myfunc "John"
```

### Returning values

```
myfunc() {
    local myresult='some value'
    echo $myresult
}
```

```
result="$(myfunc)"
```

### Raising errors

```
myfunc() {
  return 1
}
```

```
if myfunc; then
  echo "success"
else
  echo "failure"
fi
```

### Arguments

Expression

Description

`$#`

Number of arguments

`$*`

All positional arguments (as a single word)

`$@`

All positional arguments (as separate strings)

`$1`

First argument

`$_`

Last argument of the previous command

**Note**: `$@` and `$*` must be quoted in order to perform as described. Otherwise, they do exactly the same thing (arguments as separate strings).

See [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

## [#](https://devhints.io/bash#conditionals)Conditionals

### Conditions

Note that `[[` is actually a command/program that returns either `0` (true) or `1` (false). Any program that obeys the same logic (like all base utils, such as `grep(1)` or `ping(1)`) can be used as condition, see examples.

Condition

Description

`[[ -z STRING ]]`

Empty string

`[[ -n STRING ]]`

Not empty string

`[[ STRING == STRING ]]`

Equal

`[[ STRING != STRING ]]`

Not Equal

`[[ NUM -eq NUM ]]`

Equal

`[[ NUM -ne NUM ]]`

Not equal

`[[ NUM -lt NUM ]]`

Less than

`[[ NUM -le NUM ]]`

Less than or equal

`[[ NUM -gt NUM ]]`

Greater than

`[[ NUM -ge NUM ]]`

Greater than or equal

`[[ STRING =~ STRING ]]`

Regexp

`(( NUM < NUM ))`

Numeric conditions

#### More conditions

Condition

Description

`[[ -o noclobber ]]`

If OPTIONNAME is enabled

`[[ ! EXPR ]]`

Not

`[[ X && Y ]]`

And

`[[ X || Y ]]`

Or

### File conditions

Condition

Description

`[[ -e FILE ]]`

Exists

`[[ -r FILE ]]`

Readable

`[[ -h FILE ]]`

Symlink

`[[ -d FILE ]]`

Directory

`[[ -w FILE ]]`

Writable

`[[ -s FILE ]]`

Size is > 0 bytes

`[[ -f FILE ]]`

File

`[[ -x FILE ]]`

Executable

`[[ FILE1 -nt FILE2 ]]`

1 is more recent than 2

`[[ FILE1 -ot FILE2 ]]`

2 is more recent than 1

`[[ FILE1 -ef FILE2 ]]`

Same files

### Example

```

if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
else
  echo "This never happens"
fi
```

```

if [[ X && Y ]]; then
  ...
fi
```

```

if [[ "$A" == "$B" ]]
```

```

if [[ "A" =~ . ]]
```

```
if (( $a < $b )); then
   echo "$a is smaller than $b"
fi
```

```
if [[ -e "file.txt" ]]; then
  echo "file exists"
fi
```

## [#](https://devhints.io/bash#arrays)Arrays

### Defining arrays

```
Fruits=('Apple' 'Banana' 'Orange')
```

```
Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"
```

### Working with arrays

```
echo ${Fruits[0]}
echo ${Fruits[-1]}
echo ${Fruits[@]}
echo ${#Fruits[@]}
echo ${#Fruits}
echo ${#Fruits[3]}
echo ${Fruits[@]:3:2}
echo ${!Fruits[@]}
```

### Operations

```
Fruits=("${Fruits[@]}" "Watermelon")
Fruits+=('Watermelon')
Fruits=( ${Fruits[@]/Ap*/} )
unset Fruits[2]
Fruits=("${Fruits[@]}")
Fruits=("${Fruits[@]}" "${Veggies[@]}")
lines=(`cat "logfile"`)
```

### Iteration

```
for i in "${arrayName[@]}"; do
  echo $i
done
```

## [#](https://devhints.io/bash#dictionaries)Dictionaries

### Defining

```
declare -A sounds
```

```
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
```

Declares `sound` as a Dictionary object (aka associative array).

### Working with dictionaries

```
echo ${sounds[dog]}
echo ${sounds[@]}
echo ${!sounds[@]}
echo ${#sounds[@]}
unset sounds[dog]
```

### Iteration

#### Iterate over values

```
for val in "${sounds[@]}"; do
  echo $val
done
```

#### Iterate over keys

```
for key in "${!sounds[@]}"; do
  echo $key
done
```

## [#](https://devhints.io/bash#options)Options

### Options

```
set -o noclobber
set -o errexit
set -o pipefail
set -o nounset
```

### Glob options

```
shopt -s nullglob
shopt -s failglob
shopt -s nocaseglob
shopt -s dotglob
shopt -s globstar
```

Set `GLOBIGNORE` as a colon-separated list of patterns to be removed from glob matches.

## [#](https://devhints.io/bash#history)History

### Commands

Command

Description

`history`

Show history

`shopt -s histverify`

Don’t execute expanded result immediately

### Expansions

Expression

Description

`!$`

Expand last parameter of most recent command

`!*`

Expand all parameters of most recent command

`!-n`

Expand `n`th most recent command

`!n`

Expand `n`th command in history

`!<command>`

Expand most recent invocation of command `<command>`

### Operations

Code

Description

`!!`

Execute last command again

`!!:s/<FROM>/<TO>/`

Replace first occurrence of `<FROM>` to `<TO>` in most recent command

`!!:gs/<FROM>/<TO>/`

Replace all occurrences of `<FROM>` to `<TO>` in most recent command

`!$:t`

Expand only basename from last parameter of most recent command

`!$:h`

Expand only directory from last parameter of most recent command

`!!` and `!$` can be replaced with any valid expansion.

### Slices

Code

Description

`!!:n`

Expand only `n`th token from most recent command (command is `0`; first argument is `1`)

`!^`

Expand first argument from most recent command

`!$`

Expand last token from most recent command

`!!:n-m`

Expand range of tokens from most recent command

`!!:n-$`

Expand `n`th token to last from most recent command

`!!` can be replaced with any valid expansion i.e. `!cat`, `!-2`, `!42`, etc.

## [#](https://devhints.io/bash#miscellaneous)Miscellaneous

### Numeric calculations

```
$((a + 200))
```

```
$(($RANDOM%200))
```

### Subshells

```
(cd somedir; echo "I'm now in $PWD")
pwd
```

### Redirection

```
python hello.py > output.txt
python hello.py >> output.txt
python hello.py 2> error.log
python hello.py 2>&1
python hello.py 2>/dev/null
python hello.py &>/dev/null
```

```
python hello.py < foo.txt
```

### Trap errors

```
trap 'echo Error at about $LINENO' ERR
```

or

```
traperr() {
  echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR
```

### Case/switch

```
case "$1" in
  start | up)
    vagrant up
    ;;

  *)
    echo "Usage: $0 {start|stop|ssh}"
    ;;
esac
```

### Source relative

```
source "${0%/*}/../share/foo.sh"
```

### printf

```
printf "Hello %s, I'm %s" Sven Olga


printf "1 + 1 = %d" 2


printf "This is how you print a float: %f" 2

```

### Getting options

```
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi
```

### Heredoc

```
cat <<END
hello world
END
```

### Reading input

```
echo -n "Proceed? [y/n]: "
read ans
echo $ans
```

```
read -n 1 ans
```

### Special variables

Expression

Description

`$?`

Exit status of last task

`$!`

PID of last background task

`$$`

PID of shell

`$0`

Filename of the shell script

`$_`

Last argrument of the previous command

See [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

### Check for command’s result

```
if ping -c 1 google.com; then
  echo "It appears you have a working internet connection"
fi
```

### Grep check

```
if grep -q 'foo' ~/.bash_history; then
  echo "You appear to have typed 'foo' in the past"
fi
```

---
