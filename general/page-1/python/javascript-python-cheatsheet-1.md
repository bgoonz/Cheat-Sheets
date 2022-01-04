# Javascript-Python-cheatsheet

### Contents <a href="#contents" id="contents"></a>

* [Versions](broken-reference)
* [Development Environments](broken-reference)
* [Running Programs](broken-reference)
* [Comments](broken-reference)
* [Semicolons](broken-reference)
* [Whitespace, Blocks](broken-reference)
* [Functions](broken-reference)
* [Arithmetic Operators](broken-reference)
* [Variables](broken-reference)
* [Data Types](broken-reference)
* [Arrays/Lists](broken-reference)
* [Slices](broken-reference)
* [Objects/Dicts](broken-reference)
* [String Formatting](broken-reference)
* [Booleans and Conditionals](broken-reference)
* [`for` Loops](broken-reference)
* [`while` Loops](broken-reference)
* [`switch` Statement](broken-reference)
* [`if` Conditionals](broken-reference)
* [Classes](broken-reference)

### Versions <a href="#versions" id="versions"></a>

#### JavaScript <a href="#javascript" id="javascript"></a>

The standard defining JavaScript (JS) is _ECMAScript_ (ES). Modern browsers and NodeJS support ES6, which has a rich feature set. Older browsers might not support all ES6 features.

The website [caniuse.com](https://caniuse.com) will show which browsers support specific JS features.

#### Python <a href="#python" id="python"></a>

Python 3.x is the current version, but there are a number of packages and sites running legacy Python 2.

On some systems, you might have to be explicit when you invoke Python about which version you want by running `python2` or `python3`. The `--version` command line switch will tell you which version is running. Example:

```
$ python --version
Python 2.7.10
$ python2 --version
-bash: python2: command not found
$ python3 --version
Python 3.6.5
```

Using `virtualenv` or `pipenv` can really ease development painpoints surrounding the version. See [Development Environments](broken-reference), below.

### Development Environments <a href="#development-environments" id="development-environments"></a>

#### JavaScript <a href="#javascript-1" id="javascript-1"></a>

For managing project packages, the classic tool is `npm`. This is slowly being superseded by the newer `yarn` tool. Choose one for a project, and don’t mix and match.

#### Python <a href="#python-1" id="python-1"></a>

For managing project packages and Python versions, the classic tool is `virtualenv`. This is slowly being superseded by the newer `pipenv` tool.

### Running Programs <a href="#running-programs" id="running-programs"></a>

#### JavaScript <a href="#javascript-2" id="javascript-2"></a>

Running from the command line with NodeJS:

```
node program.js arg1 arg2 etc
```

In a web page, a script is referenced with a `<script>` HTML tag:

#### Python <a href="#python-2" id="python-2"></a>

Running from the command line:

```
python program.py arg1 arg2 etc
```

#### JavaScript <a href="#javascript-3" id="javascript-3"></a>

Single line:

Multi-line comments:

You may not nest multi-line comments.

#### Python <a href="#python-3" id="python-3"></a>

Single line:

Python doesn’t directly support multi-line comments, but you can effectively do them by using multi-line strings `"""`:

### Semicolons <a href="#semicolons" id="semicolons"></a>

#### JavaScript <a href="#javascript-4" id="javascript-4"></a>

Javascript ends statements with semicolons, usually at the end of the line. I can also be effectively used to put multiple statements on the same line, but this is rare.

Javascript interpreters will let you get away without using semicolons at ends of lines, but you should use them.

#### Python <a href="#python-4" id="python-4"></a>

Python can separate statements by semicolons, though this is rare in practice.

### Whitespace, blocks <a href="#whitespace-blocks" id="whitespace-blocks"></a>

#### JavaScript <a href="#javascript-5" id="javascript-5"></a>

Whitespace has no special meaning. Blocks are declared with squirrely braces `{` and `}`.

#### Python <a href="#python-5" id="python-5"></a>

Indentation level is how blocks are declared. The preferred method is to use spaces, but tabs can also be used.

### Functions <a href="#functions" id="functions"></a>

#### JavaScript <a href="#javascript-6" id="javascript-6"></a>

Define functions as follows:

An alternate syntax for functions is growing increasingly common, called _arrow functions_:

#### Python <a href="#python-6" id="python-6"></a>

Define functions as follows:

Python also supports the concept of _lambda functions_, which are simple functions that can do basic operations.

### Arithmetic Operators <a href="#arithmetic-operators" id="arithmetic-operators"></a>

#### JavaScript <a href="#javascript-7" id="javascript-7"></a>

| Operator | Description                   |
| -------- | ----------------------------- |
| `+`      | Addition                      |
| `-`      | Subtraction                   |
| `*`      | Multiplication                |
| `/`      | Division                      |
| `%`      | Modulo (remainder)            |
| `--`     | Pre-decrement, post-decrement |
| `++`     | Pre-increment, post-increment |
| `**`     | Exponentiation (power)        |
| `=`      | Assignment                    |
| `+=`     | Addition assignment           |
| `-=`     | Subtraction assignment        |
| `*=`     | Multiplication assignment     |
| `/=`     | Division assignment           |
| `%=`     | Modulo assignment             |

#### Python <a href="#python-7" id="python-7"></a>

The pre- and post-increment and decrement are notably absent.

| Operator | Description               |
| -------- | ------------------------- |
| `+`      | Addition                  |
| `-`      | Subtraction               |
| `*`      | Multiplication            |
| `/`      | Division                  |
| `%`      | Modulo (remainder)        |
| `**`     | Exponentiation (power)    |
| `=`      | Assignment                |
| `+=`     | Addition assignment       |
| `-=`     | Subtraction assignment    |
| `*=`     | Multiplication assignment |
| `/=`     | Division assignment       |
| `%=`     | Modulo assignment         |

### Variables <a href="#variables" id="variables"></a>

#### Javascript <a href="#javascript-8" id="javascript-8"></a>

Variables are created upon use, but should be created with the `let` or `const` keywords.

`var` is an outdated way of declaring variables in Javascript.

#### Python <a href="#python-8" id="python-8"></a>

Variables are created upon use.

### Data Types <a href="#data-types" id="data-types"></a>

#### JavaScript <a href="#javascript-9" id="javascript-9"></a>

Multi-line strings:

Parameterized strings:

JS is _weakly typed_ so it supports operations on multiple types of data at once.

#### Python <a href="#python-9" id="python-9"></a>

Multi-line strings:

Parameterized strings:

Python is generally _strongly typed_ so it it will often complain if you try to mix and match types. You can coerce a type with the `int()`, `float()`, `str()`, and `bool()` functions.

### Arrays/Lists <a href="#arrayslists" id="arrayslists"></a>

#### JavaScript <a href="#javascript-10" id="javascript-10"></a>

In JS, lists are called _arrays_.

Arrays are zero-based.

Creating lists:

Accessing:

Length/number of elements:

#### Python <a href="#python-10" id="python-10"></a>

In Python, arrays are called _lists_.

Lists are zero-based.

Creating lists:

Accessing:

Length/Number of elements:

**Slices**

In Python, we can access parts of lists or strings using slices.

Creating slices:

Starting from the end: We can also use negative numbers when creating slices, which just means we start with the index at the end of the array, rather than the index at the beginning of the array.

**Tuples**

Python supports a read-only type of list called a _tuple_.

**List Comprehensions**

Python supports building lists with _list comprehensions_. This is often useful for filtering lists.

### Objects/Dicts <a href="#objectsdicts" id="objectsdicts"></a>

#### JavaScript <a href="#javascript-11" id="javascript-11"></a>

_Objects_ hold data which can be found by a specific key called a _property_.

Creation:

Access:

#### Python <a href="#python-11" id="python-11"></a>

_Dicts_ hold information that can be accessed by a _key_.

Unlike objects in JS, a `dict` is its own beast, and is not the same as an object obtained by instantiating a Python class.

Creation:

Access:

Dot notation does not work with Python dicts.

### String Formatting <a href="#string-formatting" id="string-formatting"></a>

#### JavaScript <a href="#javascript-12" id="javascript-12"></a>

Converting to different number bases:

Controlling floating point precision:

Padding and justification:

Parameterized strings:

#### Python <a href="#python-12" id="python-12"></a>

Python has the printf operator `%` which is tremendously powerful. (If the operands to `%` are numbers, modulo is performed. If the left operand is a string, printf is performed.)

But even `%` is being superseded by the `format` function.

[Tons of details at pyformat.info](https://pyformat.info).

Also see [printf-style String Formatting](https://docs.python.org/3/library/stdtypes.html#printf-style-string-formatting) for a reference.

### Booleans and Conditionals <a href="#booleans-and-conditionals" id="booleans-and-conditionals"></a>

#### JavaScript <a href="#javascript-13" id="javascript-13"></a>

Literal boolean values:

Boolean operators:

| Operator | Definition            |
| -------- | --------------------- |
| `==`     | Equality              |
| `!=`     | Inequality            |
| `===`    | Strict equality       |
| `!==`    | Strict inequality     |
| `<`      | Less than             |
| `>`      | Greater than          |
| `<=`     | Less than or equal    |
| `>=`     | Greater than or equal |

The concept of strict equality/inequality applies to items that might normally be converted into a compatible type. The strict tests will consider if the types themselves are the same.

Logical operators: |Operator|Description| |–|–| |`!`|Logical inverse, not| |`&&`|Logical AND| |`||`|Logical OR|

The not operator `!` can be used to test whether or not a value is “truthy”.

Example:

#### Python <a href="#python-13" id="python-13"></a>

Literal boolean values:

Boolean operators:

| Operator | Definition            |
| -------- | --------------------- |
| `==`     | Equality              |
| `!=`     | Inequality            |
| `<`      | Less than             |
| `>`      | Greater than          |
| `<=`     | Less than or equal    |
| `>=`     | Greater than or equal |

Logical operators:

| Operator | Description          |
| -------- | -------------------- |
| `not`    | Logical inverse, not |
| `and`    | Logical AND          |
| `or`     | Logical OR           |

The `not` operator can be used to test whether or not a value is “truthy”.

Example:

### `for` Loops <a href="#for-loops" id="for-loops"></a>

#### JavaScript <a href="#javascript-14" id="javascript-14"></a>

C-style `for` loops:

`for`-`in` loops iterate over the properties of an object or indexes of an array:

`for`-`of` loops access the values within the array (as opposed to the indexes of the array):

#### Python <a href="#python-14" id="python-14"></a>

`for`-`in` loops over an _iteratable_. This can be a list, object, or other type of iterable item.

Counting loops:

Iterating over other types:

### `while` Loops <a href="#while-loops" id="while-loops"></a>

#### JavaScript <a href="#javascript-15" id="javascript-15"></a>

C-style `while` and `do`-`while`:

#### Python <a href="#python-15" id="python-15"></a>

Python has a `while` loop:

### `switch` Statement <a href="#switch-statement" id="switch-statement"></a>

#### JavaScript <a href="#javascript-16" id="javascript-16"></a>

JS can switch on various data types:

#### Python <a href="#python-16" id="python-16"></a>

Python doesn’t have a `switch` statement. You can use `if`-`elif`-`else` blocks.

A somewhat clumsy approximation of a `switch` can be constructed with a `dict` of functions.

### `if` Conditionals <a href="#if-conditionals" id="if-conditionals"></a>

#### JavaScript <a href="#javascript-17" id="javascript-17"></a>

JS uses C-style `if` statements:

#### Python <a href="#python-17" id="python-17"></a>

Python notably uses `elif` instead of `else if`.

### Classes <a href="#classes" id="classes"></a>

#### JavaScript <a href="#javascript-18" id="javascript-18"></a>

The current object is referred to by `this`.

Pre ES-2015, classes were created using functions. This is now outdated.

JS uses prototypal inheritance. Pre ES-2015, this was explicit, and is also outdated:

Modern JS introduced the `class` keyword and a syntax more familiar to most other OOP languages. Note that the inheritance model is still prototypal inheritance; it’s just that the details are hidden from the developer.

JS does not support multiple inheritance since each object can only have one prototype object. You have to use a _mix-in_ if you want to achieve similar functionality.

#### Python <a href="#python-18" id="python-18"></a>

The current object is referred to by `self`. Note that `self` is explicitly present as the first parameter in object methods.

Python 2 syntax:

Python 3 syntax includes the new `super()` keyword to make life easier.

Python supports multiple inheritance.
