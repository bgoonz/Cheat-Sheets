# Python

### Table of Contents

1. **Getting Started**
   * What is Python
   * Python Syntax
   * Variables
2. **Operators**
   * Arithmetic Operators (`+`, `-`, `*`, `/`, `//`, `%`, `**`)
   * Bitwise Operators (`&`, `|`, `^`, `>>`, `<<`, `~`)
   * Assignment Operators (`=`, `+=`, `-=`, `/=`, `//=` etc.)
   * Comparison Operator (`==`, `!=`, `>`, `<`, `>=`, `<=`)
   * Logical Operators (`and`, `or`, `not`)
   * Identity Operators (`is`, `is not`)
   * Membership Operators (`in`, `not in`)
3. **Data Types**
   * Numbers (including booleans)
   * Strings and their methods
   * Lists and their methods (including list comprehensions)
   * Tuples
   * Sets and their methods
   * Dictionaries
   * Type Casting
4. **Control Flow**
   * The `if` statement
   * The `for` statement (and `range()` function)
   * The `while` statement
   * The `try` statements
   * The `break` statement
   * The `continue` statement
5. **Functions**
   * Function Definition (`def` and `return` statements)
   * Scopes of Variables Inside Functions (`global` and `nonlocal` statements)
   * Default Argument Values
   * Keyword Arguments
   * Arbitrary Argument Lists
   * Unpacking Argument Lists (`*` and `**` statements)
   * Lambda Expressions (`lambda` statement)
   * Documentation Strings
   * Function Annotations
   * Function Decorators
6. **Classes**
   * Class Definition (`class` statement)
   * Class Objects
   * Instance Objects
   * Method Objects
   * Class and Instance Variables
   * Inheritance
   * Multiple Inheritance
7. **Modules**
   * Modules (`import` statement)
   * Packages
8. **Errors and Exceptions**
   * Handling Exceptions (`try` statement)
   * Raising Exceptions (`raise` statement)
9. **Files**
   * Reading and Writing (`with` statement)
   * Methods of File Objects
10. **Additions**
    * The `pass` statement
    * Generators (`yield` statement)
11. **Brief Tour of the Standard Libraries**
    * Serialization (`json` library)
    * File Wildcards (`glob` library)
    * String Pattern Matching (`re` library)
    * Mathematics (`math`, `random`, `statistics` libraries)
    * Dates and Times (`datetime` library)
    * Data Compression (`zlib` library)
12. **User input**
    * Terminal input (`input` statement)

### Prerequisites

**Installing Python**

Make sure that you have [Python3 installed](https://realpython.com/installing-python/) on your machine.

You might want to use [venv](https://docs.python.org/3/library/venv.html) standard Python library to create virtual environments and have Python, pip and all dependent packages to be installed and served from the local project directory to avoid messing with system wide packages and their versions.

Depending on your installation you might have access to Python3 interpreter either by running `python` or `python3`. The same goes for pip package manager - it may be accessible either by running `pip` or `pip3`.

You may check your Python version by running:

```bash
python --version
```

Note that in this repository whenever you see `python` it will be assumed that it is Python **3**.

**Installing dependencies**

Install all dependencies that are required for the project by running:

```bash
pip install -r requirements.txt
```

### Testing the Code

Tests are made using [pytest](https://docs.pytest.org/en/latest/) framework.

You may add new tests for yourself by adding files and functions with `test_` prefix (i.e. `test_topic.py` with `def test_sub_topic()` function inside).

To run all the tests please execute the following command from the project root folder:

```bash
pytest
```

To run specific tests please execute:

```bash
pytest ./path/to/the/test_file.py
```

### Linting the Code

Linting is done using [pylint](http://pylint.pycqa.org) and [flake8](http://flake8.pycqa.org/en/latest/) libraries.

#### PyLint

To check if the code is written with respect to [PEP 8](https://www.python.org/dev/peps/pep-0008/) style guide please run:

```bash
pylint ./src/
```

In case if linter will detect error (i.e. `missing-docstring`) you may want to read more about specific error by running:

```bash
pylint --help-msg=missing-docstring
```

[More about PyLint](http://pylint.pycqa.org)

#### Flake8

To check if the code is written with respect to [PEP 8](https://www.python.org/dev/peps/pep-0008/) style guide please run:

```bash
flake8 ./src
```

Or if you want to have more detailed output you may run:

```bash
flake8 ./src --statistics --show-source --count
```
