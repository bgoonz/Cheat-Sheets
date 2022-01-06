# ES6 EXPORTS

1. **There are 2 types of exports:** a. Named Exports b. Default Exports
2. **You can have as many `named exports` as you want in a file/module.**\
   **But you can only have \_ONE**\_\*\* `default export`.\*\*
3. **You can export any data structure you choose.**
4. **If you do not export a variable or function from the file it will not be accessible to other files/modules**

## Named Export Examples

```js
export const str = 'Hello World';

export const num1 = 100;
export const num2 = 200;

export const array = ['apple', 'pear', 'banana'];

export const obj = {
  firstName: 'Foo',
  lastName: 'Bar'
};

export function add(number1, number2) {
  return number1 + number2;
}
```

**You Can Only Have One Default export per module/file**

```js
export default subtract(number1, number2){
return number1 - number2;
}
```

_**This also applies to components. If you have more than one component in the same file to export, you can only export default one of them**_

Go to Imports to see how to import

## LINKS

1. Learning Objectives, (no answers)
2. Learning Objectives With Answers
3. Imports CheatSheet
4. Exports CheatSheet
5. Imports, Exports One-to-One
