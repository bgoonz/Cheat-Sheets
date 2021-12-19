# JavaScript \\| MDN

### Unicode property escapes <a href="#unicode_property_escapes" id="unicode_property_escapes"></a>

::: {.hidden} If you are looking to contribute to this document, please also edit the original article :::

```
// Non-binary values
\p{UnicodePropertyValue}
\p{UnicodePropertyName=UnicodePropertyValue}

// Binary and non-binary values
\p{UnicodeBinaryPropertyName}

// Negation: \P is negated \p
\P{UnicodePropertyValue}
\P{UnicodeBinaryPropertyName}
```

UnicodeBinaryPropertyName

The name of a binary property{.external}. E.g.: `ASCII`, `Alpha`, `Math`, `Diacritic`, `Emoji`, `Hex_Digit`, `Math`, `White_space`, etc. See Unicode Data PropList.txt{.external} for more info.

UnicodePropertyName

The name of a non-binary{.external} property:

* General\_Category{.external} (`gc`)
* Script{.external} (`sc`)
* Script\_Extensions{.external} (`scx`)

See also PropertyValueAliases.txt{.external}

UnicodePropertyValue : One of the tokens listed in the Values section, below. Many values have aliases or shorthand (e.g. the value `Decimal_Number` for the `General_Category` property may be written `Nd`, `digit`, or `Decimal_Number`). For most values, the _`UnicodePropertyName`_ part and equals sign may be omitted. If a \*`UnicodePropertyName` \*is specified, the value must correspond to the property type given.

::: {.blockIndicator .note} **Note:** As there are many properties and values available, we will not describe them exhaustively here but rather provide various examples :::

::: {.metadata} ::: {.section .document-meta}

**Metadata**

* **Last modified:** Aug 1, 2020, by MDN contributors ::: ::: :::

::: {#sidebar-quicklinks .sidebar} ::: {.quick-links} ::: {.quick-links-head .sidebar-heading} Related Topics :::

1. _**JavaScript**_
2. **Tutorials:**
3. Complete beginners
   1. JavaScript basics
   2. JavaScript first steps
   3. JavaScript building blocks
   4. Introducing JavaScript objects
4. JavaScript Guide
   1. Introduction
   2. Grammar and types
   3. Control flow and error handling
   4. Loops and iteration
   5. Functions
   6. Expressions and operators
   7. Numbers and dates
   8. Text formatting
   9. Regular expressions
   10. Indexed collections
   11. Keyed collections
   12. Working with objects
   13. Details of the object model
   14. Using promises
   15. Iterators and generators
   16. Meta programming
   17. JavaScript modules
5. Intermediate
   1. Client-side JavaScript frameworks
   2. Client-side web APIs
   3. A re-introduction to JavaScript
   4. JavaScript data structures
   5. Equality comparisons and sameness
   6. Closures
6. Advanced
   1. Inheritance and the prototype chain
   2. Strict mode
   3. JavaScript typed arrays
   4. Memory Management
   5. Concurrency model and Event Loop
7. **References:**
8. Built-in objects
   1. \[\[ ]{.icon-only-inline title="This is an experimental API that should not be used in production code."}]{.sidebar-icon}AggregateError
   2. Array
   3. ArrayBuffer
   4. AsyncFunction
   5. Atomics
   6. BigInt
   7. BigInt64Array
   8. BigUint64Array
   9. Boolean
   10. DataView
   11. Date
   12. Error
   13. EvalError
   14. FinalizationRegistry
   15. Float32Array
   16. Float64Array
   17. Function
   18. Generator
   19. GeneratorFunction
   20. Infinity
   21. Int16Array
   22. Int32Array
   23. Int8Array
   24. InternalError
   25. Intl
   26. JSON
   27. Map
   28. Math
   29. NaN
   30. Number
   31. Object
   32. Promise
   33. Proxy
   34. RangeError
   35. ReferenceError
   36. Reflect
   37. RegExp
   38. Set
   39. SharedArrayBuffer
   40. String
   41. \[Symbol]\(../../Reference/Global\_Objects/Symbol.html "The data type symbol is a primitive data type. The Symbol() function returns a value of type symbol, has static properties that expose several members of built-in objects, has static methods that expose the global symbol registry, and resembles a built-in object class, but is incomplete as a constructor because it does not support the syntax "new Symbol()".")
   42. SyntaxError
   43. TypeError
   44. TypedArray
   45. URIError
   46. Uint16Array
   47. Uint32Array
   48. Uint8Array
   49. Uint8ClampedArray
   50. WeakMap
   51. WeakRef
   52. WeakSet
   53. WebAssembly
   54. decodeURI()
   55. decodeURIComponent()
   56. \[encodeURI()]\(../../Reference/Global\_Objects/encodeURI.html "The encodeURI() function encodes a URI by replacing each instance of certain characters by one, two, three, or four escape sequences representing the UTF-8 encoding of the character (will only be four escape sequences for characters composed of two "surrogate" characters).")
   57. \[encodeURIComponent()]\(../../Reference/Global\_Objects/encodeURIComponent.html "The encodeURIComponent() function encodes a URI by replacing each instance of certain characters by one, two, three, or four escape sequences representing the UTF-8 encoding of the character (will only be four escape sequences for characters composed of two "surrogate" characters).")
   58. \[\[ ]{.icon-only-inline title="This deprecated API should no longer be used, but will probably still work."}]{.sidebar-icon}escape()
   59. eval()
   60. globalThis
   61. isFinite()
   62. isNaN()
   63. null
   64. parseFloat()
   65. parseInt()
   66. undefined
   67. \[\[ ]{.icon-only-inline title="This deprecated API should no longer be used, but will probably still work."}]{.sidebar-icon}unescape()
   68. \[\[ ]{.icon-only-inline title="This API has not been standardized."}]{.sidebar-icon}uneval()
9. Expressions & operators
   1. Addition (+)
   2. Addition assignment (+=)
   3. Assignment (=)
   4. Bitwise AND (&)
   5. Bitwise AND assignment (&=)
   6. Bitwise NOT (\~)
   7. Bitwise OR (|)
   8. Bitwise OR assignment (|=)
   9. Bitwise XOR (^)
   10. Bitwise XOR assignment (^=)
   11. Comma operator (,)
   12. Conditional (ternary) operator
   13. Decrement (--)
   14. Destructuring assignment
   15. Division (/)
   16. Division assignment (/=)
   17. Equality (==)
   18. Exponentiation (\*\*)
   19. Exponentiation assignment (\*\*=)
   20. Function expression
   21. Greater than (>)
   22. Greater than or equal (>=)
   23. Grouping operator ( )
   24. Increment (++)
   25. Inequality (!=)
   26. Left shift (<<)
   27. Left shift assignment (<<=)
   28. Less than (<)
   29. Less than or equal (<=)
   30. Logical AND (&&)
   31. Logical AND assignment (&&=)
   32. Logical NOT (!)
   33. Logical OR (||)
   34. Logical OR assignment (||=)
   35. Logical nullish assignment (??=)
   36. Multiplication (\*)
   37. Multiplication assignment (\*=)
   38. Nullish coalescing operator (??)
   39. Object initializer
   40. Operator precedence
   41. Optional chaining (?.)
   42. \[\[ ]{.icon-only-inline title="This is an experimental API that should not be used in production code."}]{.sidebar-icon}Pipeline operator (|>)
   43. Property accessors
   44. Remainder (%)
   45. Remainder assignment (%=)
   46. \[Right shift (>>)]\(../../Reference/Operators/Right\_shift.html "The right shift operator (>>) shifts the first operand the specified number of bits to the right. Excess bits shifted off to the right are discarded. Copies of the leftmost bit are shifted in from the left. Since the new leftmost bit has the same value as the previous leftmost bit, the sign bit (the leftmost bit) does not change. Hence the name "sign-propagating".")
   47. Right shift assignment (>>=)
   48. Spread syntax (...)
   49. Strict equality (===)
   50. Strict inequality (!==)
   51. Subtraction (-)
   52. Subtraction assignment (-=)
   53. Unary negation (-)
   54. Unary plus (+)
   55. Unsigned right shift (>>>)
   56. Unsigned right shift assignment (>>>=)
   57. async function expression
   58. await
   59. class expression
   60. delete operator
   61. function\* expression
   62. in operator
   63. instanceof
   64. new operator
   65. new.target
   66. super
   67. this
   68. typeof
   69. void operator
   70. yield
   71. yield\*
10. Statements & declarations
    1. async function
    2. \[block]\(../../Reference/Statements/block.html "A block statement (or compound statement in other languages) is used to group zero or more statements. The block is delimited by a pair of braces ("curly brackets") and may optionally be labelled:")
    3. break
    4. class
    5. const
    6. continue
    7. debugger
    8. do...while
    9. empty
    10. export
    11. for
    12. for await...of
    13. for...in
    14. for...of
    15. function declaration
    16. function\*
    17. if...else
    18. import
    19. import.meta
    20. label
    21. let
    22. return
    23. switch
    24. throw
    25. try...catch
    26. var
    27. while
    28. \[\[ ]{.icon-only-inline title="This deprecated API should no longer be used, but will probably still work."}]{.sidebar-icon}with
11. Functions
    1. Arrow function expressions
    2. Default parameters
    3. Method definitions
    4. Rest parameters
    5. The arguments object
    6. getter
    7. setter
12. Classes
    1. Private class fields
    2. Public class fields
    3. constructor
    4. extends
    5. static
13. Errors
    1. \[Error: Permission denied to access property "x"]\(../../Reference/Errors/Property\_access\_denied.html "The JavaScript exception "Permission denied to access property" occurs when there was an attempt to access an object for which you have no permission.")
    2. \[InternalError: too much recursion]\(../../Reference/Errors/Too\_much\_recursion.html "The JavaScript exception "too much recursion" or "Maximum call stack size exceeded" occurs when there are too many function calls, or a function is missing a base case.")
    3. \[RangeError: argument is not a valid code point]\(../../Reference/Errors/Not\_a\_codepoint.html "The JavaScript exception "Invalid code point" occurs when NaN values, negative Integers (-1), non-Integers (5.4), or values larger than 0x10FFFF (1114111) are used with String.fromCodePoint().")
    4. \[RangeError: invalid array length]\(../../Reference/Errors/Invalid\_array\_length.html "The JavaScript exception "Invalid array length" occurs when creating an Array or an ArrayBuffer which has a length which is either negative or larger or equal to 232, or when setting the Array.length property to a value which is either negative or larger or equal to 232.")
    5. \[RangeError: invalid date]\(../../Reference/Errors/Invalid\_date.html "The JavaScript exception "invalid date" occurs when a string leading to an invalid date has been provided to Date or Date.parse().")
    6. \[RangeError: precision is out of range]\(../../Reference/Errors/Precision\_range.html "The JavaScript exception "precision is out of range" occurs when a number that's outside of the range of 0 and 20 (or 21) was passed into toFixed or toPrecision.")
    7. \[RangeError: radix must be an integer]\(../../Reference/Errors/Bad\_radix.html "The JavaScript exception "radix must be an integer at least 2 and no greater than 36" occurs when the optional radix parameter of the Number.prototype.toString() or the BigInt.prototype.toString() method was specified and is not between 2 and 36.")
    8. \[RangeError: repeat count must be less than infinity]\(../../Reference/Errors/Resulting\_string\_too\_large.html "The JavaScript exception "repeat count must be less than infinity" occurs when the String.prototype.repeat() method is used with a count argument that is infinity.")
    9. \[RangeError: repeat count must be non-negative]\(../../Reference/Errors/Negative\_repetition\_count.html "The JavaScript exception "repeat count must be non-negative" occurs when the String.prototype.repeat() method is used with a count argument that is a negative number.")
    10. \[ReferenceError: "x" is not defined]\(../../Reference/Errors/Not\_defined.html "The JavaScript exception "variable is not defined" occurs when there is a non-existent variable referenced somewhere.")
    11. \[ReferenceError: assignment to undeclared variable "x"]\(../../Reference/Errors/Undeclared\_var.html "The JavaScript strict mode-only exception "Assignment to undeclated variable" occurs when the value has been assigned to an undeclared variable.")
    12. \[ReferenceError: can't access lexical declaration\`X' before initialization]\(../../Reference/Errors/Cant\_access\_lexical\_declaration\_before\_init.html "The JavaScript exception "can't access lexical declaration \`variable' before initialization" occurs when a lexical variable was accessed before it was initialized. This happens within any block statement, when let or const declarations are accessed before they are defined.")
    13. \[ReferenceError: deprecated caller or arguments usage]\(../../Reference/Errors/Deprecated\_caller\_or\_arguments\_usage.html "The JavaScript strict mode-only exception "deprecated caller or arguments usage" occurs when the deprecated Function.caller or Function.arguments properties are used.")
    14. \[ReferenceError: invalid assignment left-hand side]\(../../Reference/Errors/Invalid\_assignment\_left-hand\_side.html "The JavaScript exception "invalid assignment left-hand side" occurs when there was an unexpected assignment somewhere. For example, a single "=" sign was used instead of "==" or "===".")
    15. \[ReferenceError: reference to undefined property "x"]\(../../Reference/Errors/Undefined\_prop.html "The JavaScript warning "reference to undefined property" occurs when a script attempted to access an object property which doesn't exist.")
    16. \[SyntaxError: "0"-prefixed octal literals and octal escape seq. are deprecated]\(../../Reference/Errors/Deprecated\_octal.html "The JavaScript strict mode-only exception "0-prefixed octal literals and octal escape sequences are deprecated; for octal literals use the "0o" prefix instead" occurs when deprecated octal literals and octal escape sequences are used.")
    17. \[SyntaxError: "use strict" not allowed in function with non-simple parameters]\(../../Reference/Errors/Strict\_Non\_Simple\_Params.html "The JavaScript exception "'use strict' not allowed in function" occurs when a "use strict" directive is used at the top of a function with default parameters, rest parameters, or destructuring parameters.")
    18. \[SyntaxError: "x" is a reserved identifier]\(../../Reference/Errors/Reserved\_identifier.html "The JavaScript exception "variable is a reserved identifier" occurs when reserved keywords are used as identifiers.")
    19. SyntaxError: JSON.parse: bad parsing
    20. \[SyntaxError: Malformed formal parameter]\(../../Reference/Errors/Malformed\_formal\_parameter.html "The JavaScript exception "malformed formal parameter" occurs when the argument list of a Function() constructor call is invalid somehow.")
    21. \[SyntaxError: Unexpected token]\(../../Reference/Errors/Unexpected\_token.html "The JavaScript exceptions "unexpected token" occur when a specific language construct was expected, but something else was provided. This might be a simple typo.")
    22. \[SyntaxError: Using //@ to indicate sourceURL pragmas is deprecated. Use //# instead]\(../../Reference/Errors/Deprecated\_source\_map\_pragma.html "The JavaScript warning "Using //@ to indicate sourceURL pragmas is deprecated. Use //# instead" occurs when there is a deprecated source map syntax in a JavaScript source.")
    23. \[SyntaxError: a declaration in the head of a for-of loop can't have an initializer]\(../../Reference/Errors/Invalid\_for-of\_initializer.html "The JavaScript exception "a declaration in the head of a for-of loop can't have an initializer" occurs when the head of a for...of loop contains an initializer expression such as |for (var i = 0 of iterable)|. This is not allowed in for-of loops.")
    24. \[SyntaxError: applying the 'delete' operator to an unqualified name is deprecated]\(../../Reference/Errors/Delete\_in\_strict\_mode.html "The JavaScript strict mode-only exception "applying the 'delete' operator to an unqualified name is deprecated" occurs when variables are attempted to be deleted using the delete operator.")
    25. \[SyntaxError: for-in loop head declarations may not have initializers]\(../../Reference/Errors/Invalid\_for-in\_initializer.html "The JavaScript strict mode-only exception "for-in loop head declarations may not have initializers" occurs when the head of a for...in contains an initializer expression, such as |for (var i = 0 in obj)|. This is not allowed in for-of loops in strict mode.")
    26. \[SyntaxError: function statement requires a name]\(../../Reference/Errors/Unnamed\_function\_statement.html "The JavaScript exception "function statement requires a name" occurs when there is a function statement in the code that requires a name.")
    27. \[SyntaxError: identifier starts immediately after numeric literal]\(../../Reference/Errors/Identifier\_after\_number.html "The JavaScript exception "identifier starts immediately after numeric literal" occurs when an identifier started with a digit. Identifiers can only start with a letter, underscore (\_), or dollar sign ($).")
    28. \[SyntaxError: illegal character]\(../../Reference/Errors/Illegal\_character.html "The JavaScript exception "illegal character" occurs when there is an invalid or unexpected token that doesn't belong at this position in the code.")
    29. \[SyntaxError: invalid regular expression flag "x"]\(../../Reference/Errors/Bad\_regexp\_flag.html "The JavaScript exception "invalid regular expression flag" occurs when the flags, defined after the second slash in regular expression literal, are not one of g, i, m, s, u, or y.")
    30. \[SyntaxError: missing ) after argument list]\(../../Reference/Errors/Missing\_parenthesis\_after\_argument\_list.html "The JavaScript exception "missing ) after argument list" occurs when there is an error with how a function is called. This might be a typo, a missing operator, or an unescaped string.")
    31. \[SyntaxError: missing ) after condition]\(../../Reference/Errors/Missing\_parenthesis\_after\_condition.html "The JavaScript exception "missing ) after condition" occurs when there is an error with how an if condition is written. It must appear in parenthesis after the if keyword.")
    32. \[SyntaxError: missing : after property id]\(../../Reference/Errors/Missing\_colon\_after\_property\_id.html "The JavaScript exception "missing : after property id" occurs when objects are created using the object initializer syntax. A colon (:) separates keys and values for the object's properties. Somehow, this colon is missing or misplaced.")
    33. \[SyntaxError: missing ; before statement]\(../../Reference/Errors/Missing\_semicolon\_before\_statement.html "The JavaScript exception "missing ; before statement" occurs when there is a semicolon (;) missing somewhere and can't be added by automatic semicolon insertion (ASI). You need to provide a semicolon, so that JavaScript can parse the source code correctly.")
    34. \[SyntaxError: missing = in const declaration]\(../../Reference/Errors/Missing\_initializer\_in\_const.html "The JavaScript exception "missing = in const declaration" occurs when a const declaration was not given a value in the same statement (like const RED\_FLAG;). You need to provide one (const RED\_FLAG = '#ff0').")
    35. \[SyntaxError: missing ] after element list]\(../../Reference/Errors/Missing\_bracket\_after\_list.html "The JavaScript exception "missing ] after element list" occurs when there is an error with the array initializer syntax somewhere. Likely there is a closing bracket ("]") or a comma (",") missing.")
    36. \[SyntaxError: missing formal parameter]\(../../Reference/Errors/Missing\_formal\_parameter.html "The JavaScript exception "missing formal parameter" occurs when your function declaration is missing valid parameters.")
    37. \[SyntaxError: missing name after . operator]\(../../Reference/Errors/Missing\_name\_after\_dot\_operator.html "The JavaScript exception "missing name after . operator" occurs when there is a problem with how the dot operator (.) is used for property access.")
    38. \[SyntaxError: missing variable name]\(../../Reference/Errors/No\_variable\_name.html "The JavaScript exception "missing variable name" occurs way too often as naming things is so hard. Or maybe a comma is wrong. Check for typos!")
    39. \[SyntaxError: missing } after function body]\(../../Reference/Errors/Missing\_curly\_after\_function\_body.html "The JavaScript exception "missing } after function body" occurs when there is a syntax mistake when creating a function somewhere. Check if any closing curly brackets or parenthesis are in the correct order.")
    40. \[SyntaxError: missing } after property list]\(../../Reference/Errors/Missing\_curly\_after\_property\_list.html "The JavaScript exception "missing } after property list" occurs when there is a mistake in the object initializer syntax somewhere. Might be in fact a missing curly bracket, but could also be a missing comma.")
    41. \[SyntaxError: redeclaration of formal parameter "x"]\(../../Reference/Errors/Redeclared\_parameter.html "The JavaScript exception "redeclaration of formal parameter" occurs when the same variable name occurs as a function parameter and is then redeclared using a let assignment in a function body again.")
    42. \[SyntaxError: return not in function]\(../../Reference/Errors/Bad\_return\_or\_yield.html "The JavaScript exception "return (or yield) not in function" occurs when a return or yield statement is called outside of a function.")
    43. \[SyntaxError: test for equality (==) mistyped as assignment (=)?]\(../../Reference/Errors/Equal\_as\_assign.html "The JavaScript warning "test for equality (==) mistyped as assignment (=)?" occurs when there was an assignment (=) when you would normally expect a test for equality (==).")
    44. \[SyntaxError: unterminated string literal]\(../../Reference/Errors/Unterminated\_string\_literal.html "The JavaScript error "unterminated string literal" occurs when there is an unterminated String somewhere. String literals must be enclosed by single (') or double (") quotes.")
    45. \[TypeError: "x" has no properties]\(../../Reference/Errors/No\_properties.html "The JavaScript exception "null (or undefined) has no properties" occurs when you attempt to access properties of null and undefined. They don't have any.")
    46. \[TypeError: "x" is (not) "y"]\(../../Reference/Errors/Unexpected\_type.html "The JavaScript exception "x is (not) y" occurs when there was an unexpected type. Oftentimes, unexpected undefined or null values.")
    47. \[TypeError: "x" is not a constructor]\(../../Reference/Errors/Not\_a\_constructor.html "The JavaScript exception "is not a constructor" occurs when there was an attempt to use an object or a variable as a constructor, but that object or variable is not a constructor.")
    48. \[TypeError: "x" is not a function]\(../../Reference/Errors/Not\_a\_function.html "The JavaScript exception "is not a function" occurs when there was an attempt to call a value from a function, but the value is not actually a function.")
    49. \[TypeError: "x" is not a non-null object]\(../../Reference/Errors/No\_non-null\_object.html "The JavaScript exception "is not a non-null object" occurs when an object is expected somewhere and wasn't provided. null is not an object and won't work.")
    50. \[TypeError: "x" is read-only]\(../../Reference/Errors/Read-only.html "The JavaScript strict mode-only exception "is read-only" occurs when a global variable or object property that was assigned to is a read-only property.")
    51. \[TypeError: 'x' is not iterable]\(../../Reference/Errors/is\_not\_iterable.html "The JavaScript exception "is not iterable" occurs when the value which is given as the right hand-side of for…of or as argument of a function such as Promise.all or TypedArray.from, is not an iterable object.")
    52. \[TypeError: More arguments needed]\(../../Reference/Errors/More\_arguments\_needed.html "The JavaScript exception "more arguments needed" occurs when there is an error with how a function is called. More arguments need to be provided.")
    53. \[TypeError: Reduce of empty array with no initial value]\(../../Reference/Errors/Reduce\_of\_empty\_array\_with\_no\_initial\_value.html "The JavaScript exception "reduce of empty array with no initial value" occurs when a reduce function is used.")
    54. \[TypeError: X.prototype.y called on incompatible type]\(../../Reference/Errors/Called\_on\_incompatible\_type.html "The JavaScript exception "called on incompatible target (or object)" occurs when a function (on a given object), is called with a this not corresponding to the type expected by the function.")
    55. \[TypeError: can't access dead object]\(../../Reference/Errors/Dead\_object.html "The JavaScript exception "can't access dead object" occurs when Firefox disallows add-ons to keep strong references to DOM objects after their parent document has been destroyed to improve in memory usage and to prevent memory leaks.")
    56. \[TypeError: can't access property "x" of "y"]\(../../Reference/Errors/Cant\_access\_property.html "The JavaScript exception "can't access property" occurs when property access was operated on undefined or null values.")
    57. \[TypeError: can't assign to property "x" on "y": not an object]\(../../Reference/Errors/Cant\_assign\_to\_property.html "The JavaScript strict mode exception "can't assign to property" occurs when attempting to create a property on primitive value such as a symbol, a string, a number or a boolean. Primitive values cannot hold any property.")
    58. \[TypeError: can't define property "x": "obj" is not extensible]\(../../Reference/Errors/Cant\_define\_property\_object\_not\_extensible.html "The JavaScript exception "can't define property "x": "obj" is not extensible" occurs when Object.preventExtensions() marked an object as no longer extensible, so that it will never have properties beyond the ones it had at the time it was marked as non-extensible.")
    59. \[TypeError: can't delete non-configurable array element]\(../../Reference/Errors/Non\_configurable\_array\_element.html "The JavaScript exception "can't delete non-configurable array element" occurs when it was attempted to shorten the length of an array, but one of the array's elements is non-configurable.")
    60. \[TypeError: can't redefine non-configurable property "x"]\(../../Reference/Errors/Cant\_redefine\_property.html "The JavaScript exception "can't redefine non-configurable property" occurs when it was attempted to redefine a property, but that property is non-configurable.")
    61. \[TypeError: cannot use 'in' operator to search for 'x' in 'y']\(../../Reference/Errors/in\_operator\_no\_object.html "The JavaScript exception "right-hand side of 'in' should be an object" occurs when the in operator was used to search in strings, or in numbers, or other primitive types. It can only be used to check if a property is in an object.")
    62. \[TypeError: cyclic object value]\(../../Reference/Errors/Cyclic\_object\_value.html "The JavaScript exception "cyclic object value" occurs when object references were found in JSON. JSON.stringify() doesn't try to solve them and fails accordingly.")
    63. \[TypeError: invalid 'instanceof' operand 'x']\(../../Reference/Errors/invalid\_right\_hand\_side\_instanceof\_operand.html "The JavaScript exception "invalid 'instanceof' operand" occurs when the right hand side operands of the instanceof operator isn't used with a constructor object, i.e. an object which has a prototype property and is callable.")
    64. \[TypeError: invalid Array.prototype.sort argument]\(../../Reference/Errors/Array\_sort\_argument.html "The JavaScript exception "invalid Array.prototype.sort argument" occurs when the argument of Array.prototype.sort() isn't either undefined or a function which compares its operands.")
    65. \[TypeError: invalid arguments]\(../../Reference/Errors/Typed\_array\_invalid\_arguments.html "The JavaScript exception "invalid arguments" occurs when typed array constructors are provided with a wrong argument.")
    66. \[TypeError: invalid assignment to const "x"]\(../../Reference/Errors/Invalid\_const\_assignment.html "The JavaScript exception "invalid assignment to const" occurs when it was attempted to alter a constant value. JavaScript const declarations can't be re-assigned or redeclared.")
    67. \[TypeError: property "x" is non-configurable and can't be deleted]\(../../Reference/Errors/Cant\_delete.html "The JavaScript exception "property is non-configurable and can't be deleted" occurs when it was attempted to delete a property, but that property is non-configurable.")
    68. \[TypeError: setting getter-only property "x"]\(../../Reference/Errors/Getter\_only.html "The JavaScript strict mode-only exception "setting getter-only property" occurs when there is an attempt to set a new value to a property for which only a getter is specified.")
    69. \[TypeError: variable "x" redeclares argument]\(../../Reference/Errors/Var\_hides\_argument.html "The JavaScript strict mode-only exception "variable redeclares argument" occurs when the same variable name occurs as a function parameter and is then redeclared using a var assignment in a function body again.")
    70. \[URIError: malformed URI sequence]\(../../Reference/Errors/Malformed\_URI.html "The JavaScript exception "malformed URI sequence" occurs when URI encoding or decoding wasn't successful.")
    71. \[Warning: -file- is being assigned a //# sourceMappingURL, but already has one]\(../../Reference/Errors/Already\_has\_pragma.html "The JavaScript warning "-file- is being assigned a //# sourceMappingURL, but already has one." occurs when a source map has been specified more than once for a given JavaScript source.")
    72. \[Warning: 08/09 is not a legal ECMA-262 octal constant]\(../../Reference/Errors/Bad\_octal.html "The JavaScript warning "08 (or 09) is not a legal ECMA-262 octal constant" occurs when 08 or 09 number literals are used. They can't be interpreted as an octal number.")
    73. \[Warning: Date.prototype.toLocaleFormat is deprecated]\(../../Reference/Errors/Deprecated\_toLocaleFormat.html "The JavaScript warning "Date.prototype.toLocaleFormat is deprecated; consider using Intl.DateTimeFormat instead" occurs when the non-standard Date.prototype.toLocaleFormat method is used.")
    74. \[Warning: JavaScript 1.6's for-each-in loops are deprecated]\(../../Reference/Errors/For-each-in\_loops\_are\_deprecated.html "The JavaScript warning "JavaScript 1.6's for-each-in loops are deprecated; consider using ES6 for-of instead" occurs when a for each (variable in obj) statement is used.")
    75. Warning: String.x is deprecated; use String.prototype.x instead
    76. \[Warning: expression closures are deprecated]\(../../Reference/Errors/Deprecated\_expression\_closures.html "The JavaScript warning "expression closures are deprecated" occurs when the non-standard expression closure syntax (shorthand function syntax) is used.")
    77. \[Warning: unreachable code after return statement]\(../../Reference/Errors/Stmt\_after\_return.html "The JavaScript warning "unreachable code after return statement" occurs when using an expression after a return statement, or when using a semicolon-less return statement but including an expression directly after.")
14. Misc
    1. JavaScript technologies overview
    2. Lexical grammar
    3. JavaScript data structures
    4. Enumerability and ownership of properties
    5. Iteration protocols
    6. Strict mode
    7. Transitioning to strict mode
    8. Template literals
    9. Deprecated features

::: ::: ::: :::

### ::: {.section .newsletter-container} ::: <a href="#newsletter-form-container-.newsletter-.section-.newsletter-head-learn-the-best-of-web-development-le" id="newsletter-form-container-.newsletter-.section-.newsletter-head-learn-the-best-of-web-development-le"></a>

Get the latest and greatest from MDN delivered straight to your inbox.

The newsletter is offered in English only at the moment. :::

::: {.form-group .newsletter-group-email} E-mail :::

::: {#newsletter-privacy .form-group .form-group-agree .newsletter-group-privacy aria-hidden="false"} I'm okay with Mozilla handling my info as explained in this Privacy Policy. :::

::: {.newsletter-group-submit} Sign up now :::

Hide Newsletter Sign-up ::: :::

::: {.content-container} MDN Web Docs{.nav-footer-logo}

* Web Technologies
* Learn Web Development
* About MDN
* Feedback
* About
* MDN Web Docs Store
* Contact Us
* Firefox

::: {.social .social-mdn}

**MDN**

*
  *

:::

::: {.social .social-moz}

**Mozilla**

*
  *

:::

© 2005-2020 Mozilla and individual contributors. Content is available under these licenses.

* Terms
* Privacy
* Cookies ::: :::

### ::: <a href="#auth-modal-.modal-.hidden-.section-.auth-providers-tabindex-1-role-dialog-aria-modal-true-aria-label" id="auth-modal-.modal-.hidden-.section-.auth-providers-tabindex-1-role-dialog-aria-modal-true-aria-label"></a>

Sign in to enjoy the benefits of an MDN account. If you haven't already created an account, you will be prompted to do so after signing in.

::: {.auth-button-container} Sign in with Github{.github-auth} Sign in with Google{.google-auth} :::

Close modal ::: :::
