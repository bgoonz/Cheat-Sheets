---
title: React
excerpt: >-
  The key abstraction that React provides is that of a component. To reiterate,
  a component is some thing that is being rendered in the browser. It could be a
  button, a form with a bunch of fields in it, a navigation bar at the top of
  the page, a single input field, etc. Any of these could be its own component.
  React doesn't place any restrictions on how large or small a component can be.
  You could have an entire static site encapsulated in a single React component,
  but that at that point you may as well not be using React. So the first thing
  to remember about a component is that a component must render something. If
  nothing is being rendered from a component, then React will throw an error.
date: '2022-01-03'
thumb_img_path: images/react-c7f40163.png
thumb_img_alt: react cheat sheet
content_img_path: images/react.jpg
content_img_alt: Icelandic horses
seo:
  title: Fragments of Iceland
  description: Iceland is a Nordic country between the North Atlantic and the Arctic Ocean.
  extra:
    - name: 'og:type'
      value: article
      keyName: property
    - name: 'og:title'
      value: Fragments of Iceland
      keyName: property
    - name: 'og:description'
      value: >-
        Iceland is a Nordic country between the North Atlantic and the Arctic
        Ocean.
      keyName: property
    - name: 'og:image'
      value: images/7.jpg
      keyName: property
      relativeUrl: true
    - name: 'twitter:card'
      value: summary_large_image
    - name: 'twitter:title'
      value: Fragments of Iceland
    - name: 'twitter:description'
      value: >-
        Iceland is a Nordic country between the North Atlantic and the Arctic
        Ocean.
    - name: 'twitter:image'
      value: images/7.jpg
      relativeUrl: true
template: post
---

## Sequelize:

---

### Cheatsheet:

# Sequelize Cheatsheet

## Command Line

Sequelize provides utilities for generating migrations, models, and seed files. They are exposed through the `sequelize-cli` command.

### Init Project

```bash
$ npx sequelize-cli init
```

You must create a database user, and update the `config/config.json` file to match your database settings to complete the initialization process.

### Create Database

```bash
$ npx sequelize-cli db:create
```

### Generate a model and its migration

```bash
$ npx sequelize-cli model:generate --name <ModelName> --attributes <column1>:<type>,<column2>:<type>,...
```

### Run pending migrations

```bash
$ npx sequelize-cli db:migrate
```

### Rollback one migration

```bash
$ npx sequelize-cli db:migrate:undo
```

### Rollback all migrations

```bash
$ npx sequelize-cli db:migrate:undo:all
```

### Generate a new seed file

```bash
$ npx sequelize-cli seed:generate --name <descriptiveName>
```

### Run all pending seeds

```bash
$ npx sequelize-cli db:seed:all
```

### Rollback one seed

```bash
$ npx sequelize-cli db:seed:undo
```

### Rollback all seeds

```bash
$ npx sequelize-cli db:seed:undo:all
```

## Migrations

### Column Attribute Keywords

```js
<columnName>: {
    type: Sequelize.<type>,
    allowNull: <true|false>,
    unique: <true|false>,
    references: { model: <TableName> }, // This is the plural table name that the column references.
}
```

## Model Associations

### One to One between Student and Scholarship

`student.js`

```js
Student.hasOne(models.Scholarship, { foreignKey: "studentId" });
```

`scholarship.js`

```js
Scholarship.belongsTo(models.Student, { foreignKey: "studentId" });
```

### One to Many between Student and Class

`student.js`

```js
Student.belongsTo(models.Class, { foreignKey: "classId" });
```

`class.js`

```js
Class.hasMany(models.Student, { foreignKey: "classId" });
```

### Many to Many between Student and Lesson through StudentLessons table

`student.js`

```js
const columnMapping = {
  through: "StudentLesson", // This is the model name referencing the join table.
  otherKey: "lessonId",
  foreignKey: "studentId",
};

Student.belongsToMany(models.Lesson, columnMapping);
```

`lesson.js`

```js
const columnMapping = {
  through: "StudentLesson", // This is the model name referencing the join table.
  otherKey: "studentId",
  foreignKey: "lessonId",
};

Lesson.belongsToMany(models.Student, columnMapping);
```

## Query Format

### findOne

```js
<Model>.findOne({
  where: {
      <column>: {
          [Op.<operator>]: <value>
      }
  },
});
```

### findAll

```js
<Model>.findAll({
  where: {
    <column>: {
        [Op.<operator>]: <value>
    }
  },
  include: <include_specifier>,
  offset: 10,
  limit: 2
});
```

### findByPk

```js
<Model>.findByPk(<primary_key>, {
    include: <include_specifier>
});
```

### Common Where Operators

```js
const Op = Sequelize.Op

[Op.and]: [{a: 5}, {b: 6}] // (a = 5) AND (b = 6)
[Op.or]: [{a: 5}, {a: 6}]  // (a = 5 OR a = 6)
[Op.gt]: 6,                // > 6
[Op.gte]: 6,               // >= 6
[Op.lt]: 10,               // < 10
[Op.lte]: 10,              // <= 10
[Op.ne]: 20,               // != 20
[Op.eq]: 3,                // = 3
[Op.is]: null              // IS NULL
[Op.not]: true,            // IS NOT TRUE
[Op.between]: [6, 10],     // BETWEEN 6 AND 10
[Op.notBetween]: [11, 15], // NOT BETWEEN 11 AND 15
[Op.in]: [1, 2],           // IN [1, 2]
[Op.notIn]: [1, 2],        // NOT IN [1, 2]
[Op.like]: '%hat',         // LIKE '%hat'
[Op.notLike]: '%hat'       // NOT LIKE '%hat'
[Op.iLike]: '%hat'         // ILIKE '%hat' (case insensitive) (PG only)
[Op.notILike]: '%hat'      // NOT ILIKE '%hat'  (PG only)
[Op.startsWith]: 'hat'     // LIKE 'hat%'
[Op.endsWith]: 'hat'       // LIKE '%hat'
[Op.substring]: 'hat'      // LIKE '%hat%'
[Op.regexp]: '^[h|a|t]'    // REGEXP/~ '^[h|a|t]' (MySQL/PG only)
[Op.notRegexp]: '^[h|a|t]' // NOT REGEXP/!~ '^[h|a|t]' (MySQL/PG only)
[Op.iRegexp]: '^[h|a|t]'    // ~* '^[h|a|t]' (PG only)
[Op.notIRegexp]: '^[h|a|t]' // !~* '^[h|a|t]' (PG only)
[Op.like]: { [Op.any]: ['cat', 'hat']}
```

---

## sequelize-getting-started.md

[Raw](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc/raw/da71939ecd2d58ac46542b78874cfd62f955c502/Connecting2database.md)

[Connecting2database.md](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#file-connecting2database-md)

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#connecting-to-a-database)Connecting to a database

To connect to the database, you must create a Sequelize instance. This can be done by either passing the connection parameters separately to the Sequelize constructor or by passing a single connection URI:

```
const { Sequelize } = require('sequelize');

// Option 1: Passing a connection URI
const sequelize = new Sequelize('sqlite::memory:') // Example for sqlite
const sequelize = new Sequelize('postgres://user:pass@example.com:5432/dbname') // Example for postgres

// Option 2: Passing parameters separately (sqlite)
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: 'path/to/database.sqlite'
});

// Option 3: Passing parameters separately (other dialects)
const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: /* one of 'mysql' | 'mariadb' | 'postgres' | 'mssql' */
});

```

The Sequelize constructor accepts a lot of options. They are documented in the [API Reference](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#instance-constructor-constructor).

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#testing-the-connection)Testing the connection

You can use the `.authenticate()` function to test if the connection is OK:

```
try {
  await sequelize.authenticate();
  console.log('Connection has been established successfully.');
} catch (error) {
  console.error('Unable to connect to the database:', error);
}

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#closing-the-connection)Closing the connection

Sequelize will keep the connection open by default, and use the same connection for all queries. If you need to close the connection, call `sequelize.close()` (which is asynchronous and returns a Promise).

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#terminology-convention)Terminology convention

Observe that, in the examples above, `Sequelize` refers to the library itself while `sequelize` refers to an instance of Sequelize, which represents a connection to one database. This is the recommended convention and it will be followed throughout the documentation.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#tip-for-reading-the-docs)Tip for reading the docs

You are encouraged to run code examples locally while reading the Sequelize docs. This will help you learn faster. The easiest way to do this is using the SQLite dialect:

```
const { Sequelize, Op, Model, DataTypes } = require("sequelize");
const sequelize = new Sequelize("sqlite::memory:");

// Code here! It works!

```

To experiment with the other dialects, which are harder to setup locally, you can use the [Sequelize SSCCE](https://github.com/papb/sequelize-sscce) GitHub repository, which allows you to run code on all supported dialects directly from GitHub, for free, without any setup!

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#new-databases-versus-existing-databases)New databases versus existing databases

If you are starting a project from scratch, and your database is still empty, Sequelize can be used since the beginning in order to automate the creation of every table in your database.

Also, if you want to use Sequelize to connect to a database that is already filled with tables and data, that works as well! Sequelize has got you covered in both cases.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#logging)Logging

By default, Sequelize will log to console every SQL query it performs. The `options.logging` option can be used to customize this behavior, by defining the function that gets executed every time Sequelize would log something. The default value is `console.log` and when using that only the first log parameter of log function call is displayed. For example, for query logging the first parameter is the raw query and the second (hidden by default) is the Sequelize object.

Common useful values for `options.logging`:

```
const sequelize = new Sequelize('sqlite::memory:', {
  // Choose one of the logging options
  logging: console.log,                  // Default, displays the first parameter of the log function call
  logging: (...msg) => console.log(msg), // Displays all log function call parameters
  logging: false,                        // Disables logging
  logging: msg => logger.debug(msg),     // Use custom logger (e.g. Winston or Bunyan), displays the first parameter
  logging: logger.debug.bind(logger)     // Alternative way to use custom logger, displays all messages
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#promises-and-asyncawait)Promises and async/await

Most of the methods provided by Sequelize are asynchronous and therefore return Promises. They are all [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) , so you can use the Promise API (for example, using `then`, `catch`, `finally`) out of the box.

Of course, using `async` and `await` works normally as well.

[Raw](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc/raw/da71939ecd2d58ac46542b78874cfd62f955c502/hooks.md)

[hooks.md](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#file-hooks-md)

Hooks (also known as lifecycle events), are functions which are called before and after calls in sequelize are executed. For example, if you want to always set a value on a model before saving it, you can add a `beforeUpdate` hook.

Note: _You can't use hooks with instances. Hooks are used with models._

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#available-hooks)Available hooks

Sequelize provides a lot of hooks. The full list can be found in directly in the [source code - lib/hooks.js](https://github.com/sequelize/sequelize/blob/v6/lib/hooks.js#L7).

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#hooks-firing-order)Hooks firing order

The diagram below shows the firing order for the most common hooks.

_Note: this list is not exhaustive._

```
(1)
  beforeBulkCreate(instances, options)
  beforeBulkDestroy(options)
  beforeBulkUpdate(options)
(2)
  beforeValidate(instance, options)

[... validation happens ...]

(3)
  afterValidate(instance, options)
  validationFailed(instance, options, error)
(4)
  beforeCreate(instance, options)
  beforeDestroy(instance, options)
  beforeUpdate(instance, options)
  beforeSave(instance, options)
  beforeUpsert(values, options)

[... creation/update/destruction happens ...]

(5)
  afterCreate(instance, options)
  afterDestroy(instance, options)
  afterUpdate(instance, options)
  afterSave(instance, options)
  afterUpsert(created, options)
(6)
  afterBulkCreate(instances, options)
  afterBulkDestroy(options)
  afterBulkUpdate(options)

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#declaring-hooks)Declaring Hooks

Arguments to hooks are passed by reference. This means, that you can change the values, and this will be reflected in the insert / update statement. A hook may contain async actions - in this case the hook function should return a promise.

There are currently three ways to programmatically add hooks:

```
// Method 1 via the .init() method
class User extends Model {}
User.init({
  username: DataTypes.STRING,
  mood: {
    type: DataTypes.ENUM,
    values: ['happy', 'sad', 'neutral']
  }
}, {
  hooks: {
    beforeValidate: (user, options) => {
      user.mood = 'happy';
    },
    afterValidate: (user, options) => {
      user.username = 'Toni';
    }
  },
  sequelize
});

// Method 2 via the .addHook() method
User.addHook('beforeValidate', (user, options) => {
  user.mood = 'happy';
});

User.addHook('afterValidate', 'someCustomName', (user, options) => {
  return Promise.reject(new Error("I'm afraid I can't let you do that!"));
});

// Method 3 via the direct method
User.beforeCreate(async (user, options) => {
  const hashedPassword = await hashPassword(user.password);
  user.password = hashedPassword;
});

User.afterValidate('myHookAfter', (user, options) => {
  user.username = 'Toni';
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#removing-hooks)Removing hooks

Only a hook with name param can be removed.

```
class Book extends Model {}
Book.init({
  title: DataTypes.STRING
}, { sequelize });

Book.addHook('afterCreate', 'notifyUsers', (book, options) => {
  // ...
});

Book.removeHook('afterCreate', 'notifyUsers');

```

You can have many hooks with same name. Calling `.removeHook()` will remove all of them.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#global--universal-hooks)Global / universal hooks

Global hooks are hooks which are run for all models. They can define behaviours that you want for all your models, and are especially useful for plugins. They can be defined in two ways, which have slightly different semantics:

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#default-hooks-on-sequelize-constructor-options)Default Hooks (on Sequelize constructor options)

```
const sequelize = new Sequelize(..., {
  define: {
    hooks: {
      beforeCreate() {
        // Do stuff
      }
    }
  }
});

```

This adds a default hook to all models, which is run if the model does not define its own `beforeCreate` hook:

```
const User = sequelize.define('User', {});
const Project = sequelize.define('Project', {}, {
  hooks: {
    beforeCreate() {
      // Do other stuff
    }
  }
});

await User.create({});    // Runs the global hook
await Project.create({}); // Runs its own hook (because the global hook is overwritten)

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#permanent-hooks-withsequelizeaddhook)Permanent Hooks (with `sequelize.addHook`)

```
sequelize.addHook('beforeCreate', () => {
  // Do stuff
});

```

This hook is always run, whether or not the model specifies its own `beforeCreate` hook. Local hooks are always run before global hooks:

```
const User = sequelize.define('User', {});
const Project = sequelize.define('Project', {}, {
  hooks: {
    beforeCreate() {
      // Do other stuff
    }
  }
});

await User.create({});    // Runs the global hook
await Project.create({}); // Runs its own hook, followed by the global hook

```

Permanent hooks may also be defined in the options passed to the Sequelize constructor:

```
new Sequelize(..., {
  hooks: {
    beforeCreate() {
      // do stuff
    }
  }
});

```

Note that the above is not the same as the _Default Hooks_ mentioned above. That one uses the `define` option of the constructor. This one does not.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#connection-hooks)Connection Hooks

Sequelize provides four hooks that are executed immediately before and after a database connection is obtained or released:

- `sequelize.beforeConnect(callback)`
  - The callback has the form `async (config) => /* ... */`
- `sequelize.afterConnect(callback)`
  - The callback has the form `async (connection, config) => /* ... */`
- `sequelize.beforeDisconnect(callback)`
  - The callback has the form `async (connection) => /* ... */`
- `sequelize.afterDisconnect(callback)`
  - The callback has the form `async (connection) => /* ... */`

These hooks can be useful if you need to asynchronously obtain database credentials, or need to directly access the low-level database connection after it has been created.

For example, we can asynchronously obtain a database password from a rotating token store, and mutate Sequelize's configuration object with the new credentials:

```
sequelize.beforeConnect(async (config) => {
  config.password = await getAuthToken();
});

```

These hooks may _only_ be declared as a permanent global hook, as the connection pool is shared by all models.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#instance-hooks)Instance hooks

The following hooks will emit whenever you're editing a single object:

- `beforeValidate`
- `afterValidate` / `validationFailed`
- `beforeCreate` / `beforeUpdate` / `beforeSave` / `beforeDestroy`
- `afterCreate` / `afterUpdate` / `afterSave` / `afterDestroy`

```
User.beforeCreate(user => {
  if (user.accessLevel > 10 && user.username !== "Boss") {
    throw new Error("You can't grant this user an access level above 10!");
  }
});

```

The following example will throw an error:

```
try {
  await User.create({ username: 'Not a Boss', accessLevel: 20 });
} catch (error) {
  console.log(error); // You can't grant this user an access level above 10!
};

```

The following example will be successful:

```
const user = await User.create({ username: 'Boss', accessLevel: 20 });
console.log(user); // user object with username 'Boss' and accessLevel of 20

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#model-hooks)Model hooks

Sometimes you'll be editing more than one record at a time by using methods like `bulkCreate`, `update` and `destroy`. The following hooks will emit whenever you're using one of those methods:

- `YourModel.beforeBulkCreate(callback)`
  - The callback has the form `(instances, options) => /* ... */`
- `YourModel.beforeBulkUpdate(callback)`
  - The callback has the form `(options) => /* ... */`
- `YourModel.beforeBulkDestroy(callback)`
  - The callback has the form `(options) => /* ... */`
- `YourModel.afterBulkCreate(callback)`
  - The callback has the form `(instances, options) => /* ... */`
- `YourModel.afterBulkUpdate(callback)`
  - The callback has the form `(options) => /* ... */`
- `YourModel.afterBulkDestroy(callback)`
  - The callback has the form `(options) => /* ... */`

Note: methods like `bulkCreate` do not emit individual hooks by default - only the bulk hooks. However, if you want individual hooks to be emitted as well, you can pass the `{ individualHooks: true }` option to the query call. However, this can drastically impact performance, depending on the number of records involved (since, among other things, all instances will be loaded into memory). Examples:

```
await Model.destroy({
  where: { accessLevel: 0 },
  individualHooks: true
});
// This will select all records that are about to be deleted and emit `beforeDestroy` and `afterDestroy` on each instance.

await Model.update({ username: 'Tony' }, {
  where: { accessLevel: 0 },
  individualHooks: true
});
// This will select all records that are about to be updated and emit `beforeUpdate` and `afterUpdate` on each instance.

```

If you use `Model.bulkCreate(...)` with the `updateOnDuplicate` option, changes made in the hook to fields that aren't given in the `updateOnDuplicate` array will not be persisted to the database. However it is possible to change the `updateOnDuplicate` option inside the hook if this is what you want.

```
User.beforeBulkCreate((users, options) => {
  for (const user of users) {
    if (user.isMember) {
      user.memberSince = new Date();
    }
  }

  // Add `memberSince` to updateOnDuplicate otherwise it won't be persisted
  if (options.updateOnDuplicate && !options.updateOnDuplicate.includes('memberSince')) {
    options.updateOnDuplicate.push('memberSince');
  }
});

// Bulk updating existing users with updateOnDuplicate option
await Users.bulkCreate([
  { id: 1, isMember: true },
  { id: 2, isMember: false }
], {
  updateOnDuplicate: ['isMember']
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#associations)Associations

For the most part hooks will work the same for instances when being associated.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#one-to-one-and-one-to-many-associations)One-to-One and One-to-Many associations

- When using `add`/`set` mixin methods the `beforeUpdate` and `afterUpdate` hooks will run.

- The `beforeDestroy` and `afterDestroy` hooks will only be called on associations that have `onDelete: 'CASCADE'` and `hooks: true`. For example:

```
class Projects extends Model {}
Projects.init({
  title: DataTypes.STRING
}, { sequelize });

class Tasks extends Model {}
Tasks.init({
  title: DataTypes.STRING
}, { sequelize });

Projects.hasMany(Tasks, { onDelete: 'CASCADE', hooks: true });
Tasks.belongsTo(Projects);

```

This code will run `beforeDestroy` and `afterDestroy` hooks on the Tasks model.

Sequelize, by default, will try to optimize your queries as much as possible. When calling cascade on delete, Sequelize will simply execute:

```
DELETE FROM `table` WHERE associatedIdentifier = associatedIdentifier.primaryKey

```

However, adding `hooks: true` explicitly tells Sequelize that optimization is not of your concern. Then, Sequelize will first perform a `SELECT` on the associated objects and destroy each instance, one by one, in order to be able to properly call the hooks (with the right parameters).

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#many-to-many-associations)Many-to-Many associations

- When using `add` mixin methods for `belongsToMany` relationships (that will add one or more records to the junction table) the `beforeBulkCreate` and `afterBulkCreate` hooks in the junction model will run.

  - If `{ individualHooks: true }` was passed to the call, then each individual hook will also run.

- When using `remove` mixin methods for `belongsToMany` relationships (that will remove one or more records to the junction table) the `beforeBulkDestroy` and `afterBulkDestroy` hooks in the junction model will run.

  - If `{ individualHooks: true }` was passed to the call, then each individual hook will also run.

If your association is Many-to-Many, you may be interested in firing hooks on the through model when using the `remove` call. Internally, sequelize is using `Model.destroy` resulting in calling the `bulkDestroy` instead of the `before/afterDestroy` hooks on each through instance.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#hooks-and-transactions)Hooks and Transactions

Many model operations in Sequelize allow you to specify a transaction in the options parameter of the method. If a transaction _is_ specified in the original call, it will be present in the options parameter passed to the hook function. For example, consider the following snippet:

```
User.addHook('afterCreate', async (user, options) => {
  // We can use `options.transaction` to perform some other call
  // using the same transaction of the call that triggered this hook
  await User.update({ mood: 'sad' }, {
    where: {
      id: user.id
    },
    transaction: options.transaction
  });
});

await sequelize.transaction(async t => {
  await User.create({
    username: 'someguy',
    mood: 'happy'
  }, {
    transaction: t
  });
});

```

If we had not included the transaction option in our call to `User.update` in the preceding code, no change would have occurred, since our newly created user does not exist in the database until the pending transaction has been committed.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#internal-transactions)Internal Transactions

It is very important to recognize that sequelize may make use of transactions internally for certain operations such as `Model.findOrCreate`. If your hook functions execute read or write operations that rely on the object's presence in the database, or modify the object's stored values like the example in the preceding section, you should always specify `{ transaction: options.transaction }`:

- If a transaction was used, then `{ transaction: options.transaction }` will ensure it is used again;
- Otherwise, `{ transaction: options.transaction }` will be equivalent to `{ transaction: undefined }`, which won't use a transaction (which is ok).

This way your hooks will always behave correctly.

Generated by [ESDoc(1.1.0)](https://esdoc.org/)

[Raw](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc/raw/da71939ecd2d58ac46542b78874cfd62f955c502/model-basics.md)

[model-basics.md](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#file-model-basics-md)

# [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#model-basics)Model Basics

In this tutorial you will learn what models are in Sequelize and how to use them.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#concept)Concept

Models are the essence of Sequelize. A model is an abstraction that represents a table in your database. In Sequelize, it is a class that extends [Model](https://sequelize.org/master/class/lib/model.js~Model.html).

The model tells Sequelize several things about the entity it represents, such as the name of the table in the database and which columns it has (and their data types).

A model in Sequelize has a name. This name does not have to be the same name of the table it represents in the database. Usually, models have singular names (such as `User`) while tables have pluralized names (such as `Users`), although this is fully configurable.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#model-definition)Model Definition

Models can be defined in two equivalent ways in Sequelize:

- Calling [`sequelize.define(modelName, attributes, options)`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#instance-method-define)
- Extending [Model](https://sequelize.org/master/class/lib/model.js~Model.html) and calling [`init(attributes, options)`](https://sequelize.org/master/class/lib/model.js~Model.html#static-method-init)

After a model is defined, it is available within `sequelize.models` by its model name.

To learn with an example, we will consider that we want to create a model to represent users, which have a `firstName` and a `lastName`. We want our model to be called `User`, and the table it represents is called `Users` in the database.

Both ways to define this model are shown below. After being defined, we can access our model with `sequelize.models.User`.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#usingsequelizedefine)Using [`sequelize.define`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#instance-method-define):

```
const { Sequelize, DataTypes } = require('sequelize');
const sequelize = new Sequelize('sqlite::memory:');

const User = sequelize.define('User', {
  // Model attributes are defined here
  firstName: {
    type: DataTypes.STRING,
    allowNull: false
  },
  lastName: {
    type: DataTypes.STRING
    // allowNull defaults to true
  }
}, {
  // Other model options go here
});

// `sequelize.define` also returns the model
console.log(User === sequelize.models.User); // true

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#extendingmodel)Extending [Model](https://sequelize.org/master/class/lib/model.js~Model.html)

```
const { Sequelize, DataTypes, Model } = require('sequelize');
const sequelize = new Sequelize('sqlite::memory:');

class User extends Model {}

User.init({
  // Model attributes are defined here
  firstName: {
    type: DataTypes.STRING,
    allowNull: false
  },
  lastName: {
    type: DataTypes.STRING
    // allowNull defaults to true
  }
}, {
  // Other model options go here
  sequelize, // We need to pass the connection instance
  modelName: 'User' // We need to choose the model name
});

// the defined model is the class itself
console.log(User === sequelize.models.User); // true

```

Internally, `sequelize.define` calls `Model.init`, so both approaches are essentially equivalent.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#table-name-inference)Table name inference

Observe that, in both methods above, the table name (`Users`) was never explicitly defined. However, the model name was given (`User`).

By default, when the table name is not given, Sequelize automatically pluralizes the model name and uses that as the table name. This pluralization is done under the hood by a library called [inflection](https://www.npmjs.com/package/inflection), so that irregular plurals (such as `person -> people`) are computed correctly.

Of course, this behavior is easily configurable.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#enforcing-the-table-name-to-be-equal-to-the-model-name)Enforcing the table name to be equal to the model name

You can stop the auto-pluralization performed by Sequelize using the `freezeTableName: true` option. This way, Sequelize will infer the table name to be equal to the model name, without any modifications:

```
sequelize.define('User', {
  // ... (attributes)
}, {
  freezeTableName: true
});

```

The example above will create a model named `User` pointing to a table also named `User`.

This behavior can also be defined globally for the sequelize instance, when it is created:

```
const sequelize = new Sequelize('sqlite::memory:', {
  define: {
    freezeTableName: true
  }
});

```

This way, all tables will use the same name as the model name.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#providing-the-table-name-directly)Providing the table name directly

You can simply tell Sequelize the name of the table directly as well:

```
sequelize.define('User', {
  // ... (attributes)
}, {
  tableName: 'Employees'
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#model-synchronization)Model synchronization

When you define a model, you're telling Sequelize a few things about its table in the database. However, what if the table actually doesn't even exist in the database? What if it exists, but it has different columns, less columns, or any other difference?

This is where model synchronization comes in. A model can be synchronized with the database by calling [`model.sync(options)`](https://sequelize.org/master/class/lib/model.js~Model.html#static-method-sync), an asynchronous function (that returns a Promise). With this call, Sequelize will automatically perform an SQL query to the database. Note that this changes only the table in the database, not the model in the JavaScript side.

- `User.sync()` - This creates the table if it doesn't exist (and does nothing if it already exists)
- `User.sync({ force: true })` - This creates the table, dropping it first if it already existed
- `User.sync({ alter: true })` - This checks what is the current state of the table in the database (which columns it has, what are their data types, etc), and then performs the necessary changes in the table to make it match the model.

Example:

```
await User.sync({ force: true });
console.log("The table for the User model was just (re)created!");

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#synchronizing-all-models-at-once)Synchronizing all models at once

You can use [`sequelize.sync()`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#instance-method-sync) to automatically synchronize all models. Example:

```
await sequelize.sync({ force: true });
console.log("All models were synchronized successfully.");

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#dropping-tables)Dropping tables

To drop the table related to a model:

```
await User.drop();
console.log("User table dropped!");

```

To drop all tables:

```
await sequelize.drop();
console.log("All tables dropped!");

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#database-safety-check)Database safety check

As shown above, the `sync` and `drop` operations are destructive. Sequelize accepts a `match` option as an additional safety check, which receives a RegExp:

```
// This will run .sync() only if database name ends with '_test'
sequelize.sync({ force: true, match: /_test$/ });

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#synchronization-in-production)Synchronization in production

As shown above, `sync({ force: true })` and `sync({ alter: true })` can be destructive operations. Therefore, they are not recommended for production-level software. Instead, synchronization should be done with the advanced concept of [Migrations](https://sequelize.org/master/manual/migrations.html), with the help of the [Sequelize CLI](https://github.com/sequelize/cli).

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#timestamps)Timestamps

By default, Sequelize automatically adds the fields `createdAt` and `updatedAt` to every model, using the data type `DataTypes.DATE`. Those fields are automatically managed as well - whenever you use Sequelize to create or update something, those fields will be set correctly. The `createdAt` field will contain the timestamp representing the moment of creation, and the `updatedAt` will contain the timestamp of the latest update.

Note: This is done in the Sequelize level (i.e. not done with _SQL triggers_). This means that direct SQL queries (for example queries performed without Sequelize by any other means) will not cause these fields to be updated automatically.

This behavior can be disabled for a model with the `timestamps: false` option:

```
sequelize.define('User', {
  // ... (attributes)
}, {
  timestamps: false
});

```

It is also possible to enable only one of `createdAt`/`updatedAt`, and to provide a custom name for these columns:

```
class Foo extends Model {}
Foo.init({ /* attributes */ }, {
  sequelize,

  // don't forget to enable timestamps!
  timestamps: true,

  // I don't want createdAt
  createdAt: false,

  // I want updatedAt to actually be called updateTimestamp
  updatedAt: 'updateTimestamp'
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#column-declaration-shorthand-syntax)Column declaration shorthand syntax

If the only thing being specified about a column is its data type, the syntax can be shortened:

```
// This:
sequelize.define('User', {
  name: {
    type: DataTypes.STRING
  }
});

// Can be simplified to:
sequelize.define('User', { name: DataTypes.STRING });

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#default-values)Default Values

By default, Sequelize assumes that the default value of a column is `NULL`. This behavior can be changed by passing a specific `defaultValue` to the column definition:

```
sequelize.define('User', {
  name: {
    type: DataTypes.STRING,
    defaultValue: "John Doe"
  }
});

```

Some special values, such as `DataTypes.NOW`, are also accepted:

```
sequelize.define('Foo', {
  bar: {
    type: DataTypes.DATETIME,
    defaultValue: DataTypes.NOW
    // This way, the current date/time will be used to populate this column (at the moment of insertion)
  }
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#data-types)Data Types

Every column you define in your model must have a data type. Sequelize provides [a lot of built-in data types](https://github.com/sequelize/sequelize/blob/main/lib/data-types.js). To access a built-in data type, you must import `DataTypes`:

```
const { DataTypes } = require("sequelize"); // Import the built-in data types

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#strings)Strings

```
DataTypes.STRING             // VARCHAR(255)
DataTypes.STRING(1234)       // VARCHAR(1234)
DataTypes.STRING.BINARY      // VARCHAR BINARY
DataTypes.TEXT               // TEXT
DataTypes.TEXT('tiny')       // TINYTEXT
DataTypes.CITEXT             // CITEXT          PostgreSQL and SQLite only.
DataTypes.TSVECTOR           // TSVECTOR        PostgreSQL only.

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#boolean)Boolean

```
DataTypes.BOOLEAN            // TINYINT(1)

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#numbers)Numbers

```
DataTypes.INTEGER            // INTEGER
DataTypes.BIGINT             // BIGINT
DataTypes.BIGINT(11)         // BIGINT(11)

DataTypes.FLOAT              // FLOAT
DataTypes.FLOAT(11)          // FLOAT(11)
DataTypes.FLOAT(11, 10)      // FLOAT(11,10)

DataTypes.REAL               // REAL            PostgreSQL only.
DataTypes.REAL(11)           // REAL(11)        PostgreSQL only.
DataTypes.REAL(11, 12)       // REAL(11,12)     PostgreSQL only.

DataTypes.DOUBLE             // DOUBLE
DataTypes.DOUBLE(11)         // DOUBLE(11)
DataTypes.DOUBLE(11, 10)     // DOUBLE(11,10)

DataTypes.DECIMAL            // DECIMAL
DataTypes.DECIMAL(10, 2)     // DECIMAL(10,2)

```

#### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#unsigned--zerofill-integers---mysqlmariadb-only)Unsigned & Zerofill integers - MySQL/MariaDB only

In MySQL and MariaDB, the data types `INTEGER`, `BIGINT`, `FLOAT` and `DOUBLE` can be set as unsigned or zerofill (or both), as follows:

```
DataTypes.INTEGER.UNSIGNED
DataTypes.INTEGER.ZEROFILL
DataTypes.INTEGER.UNSIGNED.ZEROFILL
// You can also specify the size i.e. INTEGER(10) instead of simply INTEGER
// Same for BIGINT, FLOAT and DOUBLE

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#dates)Dates

```
DataTypes.DATE       // DATETIME for mysql / sqlite, TIMESTAMP WITH TIME ZONE for postgres
DataTypes.DATE(6)    // DATETIME(6) for mysql 5.6.4+. Fractional seconds support with up to 6 digits of precision
DataTypes.DATEONLY   // DATE without time

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#uuids)UUIDs

For UUIDs, use `DataTypes.UUID`. It becomes the `UUID` data type for PostgreSQL and SQLite, and `CHAR(36)` for MySQL. Sequelize can generate UUIDs automatically for these fields, simply use `DataTypes.UUIDV1` or `DataTypes.UUIDV4` as the default value:

```
{
  type: DataTypes.UUID,
  defaultValue: DataTypes.UUIDV4 // Or DataTypes.UUIDV1
}

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#others)Others

There are other data types, covered in a [separate guide](https://sequelize.org/master/manual/other-data-types.html).

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#column-options)Column Options

When defining a column, apart from specifying the `type` of the column, and the `allowNull` and `defaultValue` options mentioned above, there are a lot more options that can be used. Some examples are below.

```
const { Model, DataTypes, Deferrable } = require("sequelize");

class Foo extends Model {}
Foo.init({
  // instantiating will automatically set the flag to true if not set
  flag: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },

  // default values for dates => current time
  myDate: { type: DataTypes.DATE, defaultValue: DataTypes.NOW },

  // setting allowNull to false will add NOT NULL to the column, which means an error will be
  // thrown from the DB when the query is executed if the column is null. If you want to check that a value
  // is not null before querying the DB, look at the validations section below.
  title: { type: DataTypes.STRING, allowNull: false },

  // Creating two objects with the same value will throw an error. The unique property can be either a
  // boolean, or a string. If you provide the same string for multiple columns, they will form a
  // composite unique key.
  uniqueOne: { type: DataTypes.STRING,  unique: 'compositeIndex' },
  uniqueTwo: { type: DataTypes.INTEGER, unique: 'compositeIndex' },

  // The unique property is simply a shorthand to create a unique constraint.
  someUnique: { type: DataTypes.STRING, unique: true },

  // Go on reading for further information about primary keys
  identifier: { type: DataTypes.STRING, primaryKey: true },

  // autoIncrement can be used to create auto_incrementing integer columns
  incrementMe: { type: DataTypes.INTEGER, autoIncrement: true },

  // You can specify a custom column name via the 'field' attribute:
  fieldWithUnderscores: { type: DataTypes.STRING, field: 'field_with_underscores' },

  // It is possible to create foreign keys:
  bar_id: {
    type: DataTypes.INTEGER,

    references: {
      // This is a reference to another model
      model: Bar,

      // This is the column name of the referenced model
      key: 'id',

      // With PostgreSQL, it is optionally possible to declare when to check the foreign key constraint, passing the Deferrable type.
      deferrable: Deferrable.INITIALLY_IMMEDIATE
      // Options:
      // - `Deferrable.INITIALLY_IMMEDIATE` - Immediately check the foreign key constraints
      // - `Deferrable.INITIALLY_DEFERRED` - Defer all foreign key constraint check to the end of a transaction
      // - `Deferrable.NOT` - Don't defer the checks at all (default) - This won't allow you to dynamically change the rule in a transaction
    }
  },

  // Comments can only be added to columns in MySQL, MariaDB, PostgreSQL and MSSQL
  commentMe: {
    type: DataTypes.INTEGER,
    comment: 'This is a column name that has a comment'
  }
}, {
  sequelize,
  modelName: 'foo',

  // Using `unique: true` in an attribute above is exactly the same as creating the index in the model's options:
  indexes: [{ unique: true, fields: ['someUnique'] }]
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#taking-advantage-of-models-being-classes)Taking advantage of Models being classes

The Sequelize models are [ES6 classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes). You can very easily add custom instance or class level methods.

```
class User extends Model {
  static classLevelMethod() {
    return 'foo';
  }
  instanceLevelMethod() {
    return 'bar';
  }
  getFullname() {
    return [this.firstname, this.lastname].join(' ');
  }
}
User.init({
  firstname: Sequelize.TEXT,
  lastname: Sequelize.TEXT
}, { sequelize });

console.log(User.classLevelMethod()); // 'foo'
const user = User.build({ firstname: 'Jane', lastname: 'Doe' });
console.log(user.instanceLevelMethod()); // 'bar'
console.log(user.getFullname()); // 'Jane Doe'

```

Generated by [ESDoc(1.1.0)](https://esdoc.org/)

[Raw](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc/raw/da71939ecd2d58ac46542b78874cfd62f955c502/model-querrying.md)

[model-querrying.md](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#file-model-querrying-md)

# [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#model-querying---basics)Model Querying - Basics

Sequelize provides various methods to assist querying your database for data.

_Important notice: to perform production-ready queries with Sequelize, make sure you have read the [Transactions guide](https://sequelize.org/master/manual/transactions.html) as well. Transactions are important to ensure data integrity and to provide other benefits._

This guide will show how to make the standard [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) queries.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#simple-insert-queries)Simple INSERT queries

First, a simple example:

```
// Create a new user
const jane = await User.create({ firstName: "Jane", lastName: "Doe" });
console.log("Jane's auto-generated ID:", jane.id);

```

The [`Model.create()`](https://sequelize.org/master/class/lib/model.js~Model.html#static-method-create) method is a shorthand for building an unsaved instance with [`Model.build()`](https://sequelize.org/master/class/lib/model.js~Model.html#static-method-build) and saving the instance with [`instance.save()`](https://sequelize.org/master/class/lib/model.js~Model.html#instance-method-save).

It is also possible to define which attributes can be set in the `create` method. This can be especially useful if you create database entries based on a form which can be filled by a user. Using that would, for example, allow you to restrict the `User` model to set only an username but not an admin flag (i.e., `isAdmin`):

```
const user = await User.create({
  username: 'alice123',
  isAdmin: true
}, { fields: ['username'] });
// let's assume the default of isAdmin is false
console.log(user.username); // 'alice123'
console.log(user.isAdmin); // false

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#simple-select-queries)Simple SELECT queries

You can read the whole table from the database with the [`findAll`](https://sequelize.org/master/class/lib/model.js~Model.html#static-method-findAll) method:

```
// Find all users
const users = await User.findAll();
console.log(users.every(user => user instanceof User)); // true
console.log("All users:", JSON.stringify(users, null, 2));

```

```
SELECT * FROM ...

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#specifying-attributes-for-select-queries)Specifying attributes for SELECT queries

To select only some attributes, you can use the `attributes` option:

```
Model.findAll({
  attributes: ['foo', 'bar']
});

```

```
SELECT foo, bar FROM ...

```

Attributes can be renamed using a nested array:

```
Model.findAll({
  attributes: ['foo', ['bar', 'baz'], 'qux']
});

```

```
SELECT foo, bar AS baz, qux FROM ...

```

You can use [`sequelize.fn`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#static-method-fn) to do aggregations:

```
Model.findAll({
  attributes: [
    'foo',
    [sequelize.fn('COUNT', sequelize.col('hats')), 'n_hats'],
    'bar'
  ]
});

```

```
SELECT foo, COUNT(hats) AS n_hats, bar FROM ...

```

When using aggregation function, you must give it an alias to be able to access it from the model. In the example above you can get the number of hats with `instance.n_hats`.

Sometimes it may be tiresome to list all the attributes of the model if you only want to add an aggregation:

```
// This is a tiresome way of getting the number of hats (along with every column)
Model.findAll({
  attributes: [
    'id', 'foo', 'bar', 'baz', 'qux', 'hats', // We had to list all attributes...
    [sequelize.fn('COUNT', sequelize.col('hats')), 'n_hats'] // To add the aggregation...
  ]
});

// This is shorter, and less error prone because it still works if you add / remove attributes from your model later
Model.findAll({
  attributes: {
    include: [
      [sequelize.fn('COUNT', sequelize.col('hats')), 'n_hats']
    ]
  }
});

```

```
SELECT id, foo, bar, baz, qux, hats, COUNT(hats) AS n_hats FROM ...

```

Similarly, it's also possible to remove a selected few attributes:

```
Model.findAll({
  attributes: { exclude: ['baz'] }
});

```

```
-- Assuming all columns are 'id', 'foo', 'bar', 'baz' and 'qux'
SELECT id, foo, bar, qux FROM ...

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#applying-where-clauses)Applying WHERE clauses

The `where` option is used to filter the query. There are lots of operators to use for the `where` clause, available as Symbols from [`Op`](https://sequelize.org/master/variable/index.html#static-variable-Op).

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#the-basics)The basics

```
Post.findAll({
  where: {
    authorId: 2
  }
});
// SELECT * FROM post WHERE authorId = 2;

```

Observe that no operator (from `Op`) was explicitly passed, so Sequelize assumed an equality comparison by default. The above code is equivalent to:

```
const { Op } = require("sequelize");
Post.findAll({
  where: {
    authorId: {
      [Op.eq]: 2
    }
  }
});
// SELECT * FROM post WHERE authorId = 2;

```

Multiple checks can be passed:

```
Post.findAll({
  where: {
    authorId: 12,
    status: 'active'
  }
});
// SELECT * FROM post WHERE authorId = 12 AND status = 'active';

```

Just like Sequelize inferred the `Op.eq` operator in the first example, here Sequelize inferred that the caller wanted an `AND` for the two checks. The code above is equivalent to:

```
const { Op } = require("sequelize");
Post.findAll({
  where: {
    [Op.and]: [
      { authorId: 12 },
      { status: 'active' }
    ]
  }
});
// SELECT * FROM post WHERE authorId = 12 AND status = 'active';

```

An `OR` can be easily performed in a similar way:

```
const { Op } = require("sequelize");
Post.findAll({
  where: {
    [Op.or]: [
      { authorId: 12 },
      { authorId: 13 }
    ]
  }
});
// SELECT * FROM post WHERE authorId = 12 OR authorId = 13;

```

Since the above was an `OR` involving the same field, Sequelize allows you to use a slightly different structure which is more readable and generates the same behavior:

```
const { Op } = require("sequelize");
Post.destroy({
  where: {
    authorId: {
      [Op.or]: [12, 13]
    }
  }
});
// DELETE FROM post WHERE authorId = 12 OR authorId = 13;

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#operators)Operators

Sequelize provides several operators.

```
const { Op } = require("sequelize");
Post.findAll({
  where: {
    [Op.and]: [{ a: 5 }, { b: 6 }],            // (a = 5) AND (b = 6)
    [Op.or]: [{ a: 5 }, { b: 6 }],             // (a = 5) OR (b = 6)
    someAttribute: {
      // Basics
      [Op.eq]: 3,                              // = 3
      [Op.ne]: 20,                             // != 20
      [Op.is]: null,                           // IS NULL
      [Op.not]: true,                          // IS NOT TRUE
      [Op.or]: [5, 6],                         // (someAttribute = 5) OR (someAttribute = 6)

      // Using dialect specific column identifiers (PG in the following example):
      [Op.col]: 'user.organization_id',        // = "user"."organization_id"

      // Number comparisons
      [Op.gt]: 6,                              // > 6
      [Op.gte]: 6,                             // >= 6
      [Op.lt]: 10,                             // < 10
      [Op.lte]: 10,                            // <= 10
      [Op.between]: [6, 10],                   // BETWEEN 6 AND 10
      [Op.notBetween]: [11, 15],               // NOT BETWEEN 11 AND 15

      // Other operators

      [Op.all]: sequelize.literal('SELECT 1'), // > ALL (SELECT 1)

      [Op.in]: [1, 2],                         // IN [1, 2]
      [Op.notIn]: [1, 2],                      // NOT IN [1, 2]

      [Op.like]: '%hat',                       // LIKE '%hat'
      [Op.notLike]: '%hat',                    // NOT LIKE '%hat'
      [Op.startsWith]: 'hat',                  // LIKE 'hat%'
      [Op.endsWith]: 'hat',                    // LIKE '%hat'
      [Op.substring]: 'hat',                   // LIKE '%hat%'
      [Op.iLike]: '%hat',                      // ILIKE '%hat' (case insensitive) (PG only)
      [Op.notILike]: '%hat',                   // NOT ILIKE '%hat'  (PG only)
      [Op.regexp]: '^[h|a|t]',                 // REGEXP/~ '^[h|a|t]' (MySQL/PG only)
      [Op.notRegexp]: '^[h|a|t]',              // NOT REGEXP/!~ '^[h|a|t]' (MySQL/PG only)
      [Op.iRegexp]: '^[h|a|t]',                // ~* '^[h|a|t]' (PG only)
      [Op.notIRegexp]: '^[h|a|t]',             // !~* '^[h|a|t]' (PG only)

      [Op.any]: [2, 3],                        // ANY ARRAY[2, 3]::INTEGER (PG only)
      [Op.match]: Sequelize.fn('to_tsquery', 'fat & rat') // match text search for strings 'fat' and 'rat' (PG only)

      // In Postgres, Op.like/Op.iLike/Op.notLike can be combined to Op.any:
      [Op.like]: { [Op.any]: ['cat', 'hat'] }  // LIKE ANY ARRAY['cat', 'hat']

      // There are more postgres-only range operators, see below
    }
  }
});

```

#### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#shorthand-syntax-foropin)Shorthand syntax for `Op.in`

Passing an array directly to the `where` option will implicitly use the `IN` operator:

```
Post.findAll({
  where: {
    id: [1,2,3] // Same as using `id: { [Op.in]: [1,2,3] }`
  }
});
// SELECT ... FROM "posts" AS "post" WHERE "post"."id" IN (1, 2, 3);

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#logical-combinations-with-operators)Logical combinations with operators

The operators `Op.and`, `Op.or` and `Op.not` can be used to create arbitrarily complex nested logical comparisons.

#### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#examples-withopandandopor)Examples with `Op.and` and `Op.or`

```
const { Op } = require("sequelize");

Foo.findAll({
  where: {
    rank: {
      [Op.or]: {
        [Op.lt]: 1000,
        [Op.eq]: null
      }
    },
    // rank < 1000 OR rank IS NULL

    {
      createdAt: {
        [Op.lt]: new Date(),
        [Op.gt]: new Date(new Date() - 24 * 60 * 60 * 1000)
      }
    },
    // createdAt < [timestamp] AND createdAt > [timestamp]

    {
      [Op.or]: [
        {
          title: {
            [Op.like]: 'Boat%'
          }
        },
        {
          description: {
            [Op.like]: '%boat%'
          }
        }
      ]
    }
    // title LIKE 'Boat%' OR description LIKE '%boat%'
  }
});

```

#### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#examples-withopnot)Examples with `Op.not`

```
Project.findAll({
  where: {
    name: 'Some Project',
    [Op.not]: [
      { id: [1,2,3] },
      {
        description: {
          [Op.like]: 'Hello%'
        }
      }
    ]
  }
});

```

The above will generate:

```
SELECT *
FROM `Projects`
WHERE (
  `Projects`.`name` = 'Some Project'
  AND NOT (
    `Projects`.`id` IN (1,2,3)
    AND
    `Projects`.`description` LIKE 'Hello%'
  )
)

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#advanced-queries-with-functions-not-just-columns)Advanced queries with functions (not just columns)

What if you wanted to obtain something like `WHERE char_length("content") = 7`?

```
Post.findAll({
  where: sequelize.where(sequelize.fn('char_length', sequelize.col('content')), 7)
});
// SELECT ... FROM "posts" AS "post" WHERE char_length("content") = 7

```

Note the usage of the [`sequelize.fn`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#static-method-fn) and [`sequelize.col`](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#static-method-col) methods, which should be used to specify an SQL function call and a table column, respectively. These methods should be used instead of passing a plain string (such as `char_length(content)`) because Sequelize needs to treat this situation differently (for example, using other symbol escaping approaches).

What if you need something even more complex?

```
Post.findAll({
  where: {
    [Op.or]: [
      sequelize.where(sequelize.fn('char_length', sequelize.col('content')), 7),
      {
        content: {
          [Op.like]: 'Hello%'
        }
      },
      {
        [Op.and]: [
          { status: 'draft' },
          sequelize.where(sequelize.fn('char_length', sequelize.col('content')), {
            [Op.gt]: 10
          })
        ]
      }
    ]
  }
});

```

The above generates the following SQL:

```
SELECT
  ...
FROM "posts" AS "post"
WHERE (
  char_length("content") = 7
  OR
  "post"."content" LIKE 'Hello%'
  OR (
    "post"."status" = 'draft'
    AND
    char_length("content") > 10
  )
)

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#postgres-only-range-operators)Postgres-only Range Operators

Range types can be queried with all supported operators.

Keep in mind, the provided range value can [define the bound inclusion/exclusion](https://sequelize.org/master/manual/data-types.html#range-types) as well.

```
[Op.contains]: 2,            // @> '2'::integer  (PG range contains element operator)
[Op.contains]: [1, 2],       // @> [1, 2)        (PG range contains range operator)
[Op.contained]: [1, 2],      // <@ [1, 2)        (PG range is contained by operator)
[Op.overlap]: [1, 2],        // && [1, 2)        (PG range overlap (have points in common) operator)
[Op.adjacent]: [1, 2],       // -|- [1, 2)       (PG range is adjacent to operator)
[Op.strictLeft]: [1, 2],     // << [1, 2)        (PG range strictly left of operator)
[Op.strictRight]: [1, 2],    // >> [1, 2)        (PG range strictly right of operator)
[Op.noExtendRight]: [1, 2],  // &< [1, 2)        (PG range does not extend to the right of operator)
[Op.noExtendLeft]: [1, 2],   // &> [1, 2)        (PG range does not extend to the left of operator)

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#deprecated-operator-aliases)Deprecated: Operator Aliases

In Sequelize v4, it was possible to specify strings to refer to operators, instead of using Symbols. This is now deprecated and heavily discouraged, and will probably be removed in the next major version. If you really need it, you can pass the `operatorAliases` option in the Sequelize constructor.

For example:

```
const { Sequelize, Op } = require("sequelize");
const sequelize = new Sequelize('sqlite::memory:', {
  operatorsAliases: {
    $gt: Op.gt
  }
});

// Now we can use `$gt` instead of `[Op.gt]` in where clauses:
Foo.findAll({
  where: {
    $gt: 6 // Works like using [Op.gt]
  }
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#simple-update-queries)Simple UPDATE queries

Update queries also accept the `where` option, just like the read queries shown above.

```
// Change everyone without a last name to "Doe"
await User.update({ lastName: "Doe" }, {
  where: {
    lastName: null
  }
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#simple-delete-queries)Simple DELETE queries

Delete queries also accept the `where` option, just like the read queries shown above.

```
// Delete everyone named "Jane"
await User.destroy({
  where: {
    firstName: "Jane"
  }
});

```

To destroy everything the `TRUNCATE` SQL can be used:

```
// Truncate the table
await User.destroy({
  truncate: true
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#creating-in-bulk)Creating in bulk

Sequelize provides the `Model.bulkCreate` method to allow creating multiple records at once, with only one query.

The usage of `Model.bulkCreate` is very similar to `Model.create`, by receiving an array of objects instead of a single object.

```
const captains = await Captain.bulkCreate([
  { name: 'Jack Sparrow' },
  { name: 'Davy Jones' }
]);
console.log(captains.length); // 2
console.log(captains[0] instanceof Captain); // true
console.log(captains[0].name); // 'Jack Sparrow'
console.log(captains[0].id); // 1 // (or another auto-generated value)

```

However, by default, `bulkCreate` does not run validations on each object that is going to be created (which `create` does). To make `bulkCreate` run these validations as well, you must pass the `validate: true` option. This will decrease performance. Usage example:

```
const Foo = sequelize.define('foo', {
  bar: {
    type: DataTypes.TEXT,
    validate: {
      len: [4, 6]
    }
  }
});

// This will not throw an error, both instances will be created
await Foo.bulkCreate([
  { name: 'abc123' },
  { name: 'name too long' }
]);

// This will throw an error, nothing will be created
await Foo.bulkCreate([
  { name: 'abc123' },
  { name: 'name too long' }
], { validate: true });

```

If you are accepting values directly from the user, it might be beneficial to limit the columns that you want to actually insert. To support this, `bulkCreate()` accepts a `fields` option, an array defining which fields must be considered (the rest will be ignored).

```
await User.bulkCreate([
  { username: 'foo' },
  { username: 'bar', admin: true }
], { fields: ['username'] });
// Neither foo nor bar are admins.

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#ordering-and-grouping)Ordering and Grouping

Sequelize provides the `order` and `group` options to work with `ORDER BY` and `GROUP BY`.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#ordering)Ordering

The `order` option takes an array of items to order the query by or a sequelize method. These _items_ are themselves arrays in the form `[column, direction]`. The column will be escaped correctly and the direction will be checked in a whitelist of valid directions (such as `ASC`, `DESC`, `NULLS FIRST`, etc).

```
Subtask.findAll({
  order: [
    // Will escape title and validate DESC against a list of valid direction parameters
    ['title', 'DESC'],

    // Will order by max(age)
    sequelize.fn('max', sequelize.col('age')),

    // Will order by max(age) DESC
    [sequelize.fn('max', sequelize.col('age')), 'DESC'],

    // Will order by  otherfunction(`col1`, 12, 'lalala') DESC
    [sequelize.fn('otherfunction', sequelize.col('col1'), 12, 'lalala'), 'DESC'],

    // Will order an associated model's createdAt using the model name as the association's name.
    [Task, 'createdAt', 'DESC'],

    // Will order through an associated model's createdAt using the model names as the associations' names.
    [Task, Project, 'createdAt', 'DESC'],

    // Will order by an associated model's createdAt using the name of the association.
    ['Task', 'createdAt', 'DESC'],

    // Will order by a nested associated model's createdAt using the names of the associations.
    ['Task', 'Project', 'createdAt', 'DESC'],

    // Will order by an associated model's createdAt using an association object. (preferred method)
    [Subtask.associations.Task, 'createdAt', 'DESC'],

    // Will order by a nested associated model's createdAt using association objects. (preferred method)
    [Subtask.associations.Task, Task.associations.Project, 'createdAt', 'DESC'],

    // Will order by an associated model's createdAt using a simple association object.
    [{model: Task, as: 'Task'}, 'createdAt', 'DESC'],

    // Will order by a nested associated model's createdAt simple association objects.
    [{model: Task, as: 'Task'}, {model: Project, as: 'Project'}, 'createdAt', 'DESC']
  ],

  // Will order by max age descending
  order: sequelize.literal('max(age) DESC'),

  // Will order by max age ascending assuming ascending is the default order when direction is omitted
  order: sequelize.fn('max', sequelize.col('age')),

  // Will order by age ascending assuming ascending is the default order when direction is omitted
  order: sequelize.col('age'),

  // Will order randomly based on the dialect (instead of fn('RAND') or fn('RANDOM'))
  order: sequelize.random()
});

Foo.findOne({
  order: [
    // will return `name`
    ['name'],
    // will return `username` DESC
    ['username', 'DESC'],
    // will return max(`age`)
    sequelize.fn('max', sequelize.col('age')),
    // will return max(`age`) DESC
    [sequelize.fn('max', sequelize.col('age')), 'DESC'],
    // will return otherfunction(`col1`, 12, 'lalala') DESC
    [sequelize.fn('otherfunction', sequelize.col('col1'), 12, 'lalala'), 'DESC'],
    // will return otherfunction(awesomefunction(`col`)) DESC, This nesting is potentially infinite!
    [sequelize.fn('otherfunction', sequelize.fn('awesomefunction', sequelize.col('col'))), 'DESC']
  ]
});

```

To recap, the elements of the order array can be the following:

- A string (which will be automatically quoted)
- An array, whose first element will be quoted, second will be appended verbatim
- An object with a `raw` field:
  - The content of `raw` will be added verbatim without quoting
  - Everything else is ignored, and if raw is not set, the query will fail
- A call to `Sequelize.fn` (which will generate a function call in SQL)
- A call to `Sequelize.col` (which will quoute the column name)

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#grouping)Grouping

The syntax for grouping and ordering are equal, except that grouping does not accept a direction as last argument of the array (there is no `ASC`, `DESC`, `NULLS FIRST`, etc).

You can also pass a string directly to `group`, which will be included directly (verbatim) into the generated SQL. Use with caution and don't use with user generated content.

```
Project.findAll({ group: 'name' });
// yields 'GROUP BY name'

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#limits-and-pagination)Limits and Pagination

The `limit` and `offset` options allow you to work with limiting / pagination:

```
// Fetch 10 instances/rows
Project.findAll({ limit: 10 });

// Skip 8 instances/rows
Project.findAll({ offset: 8 });

// Skip 5 instances and fetch the 5 after that
Project.findAll({ offset: 5, limit: 5 });

```

Usually these are used alongside the `order` option.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#utility-methods)Utility methods

Sequelize also provides a few utility methods.

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#count)`count`

The `count` method simply counts the occurrences of elements in the database.

```
console.log(`There are ${await Project.count()} projects`);

const amount = await Project.count({
  where: {
    id: {
      [Op.gt]: 25
    }
  }
});
console.log(`There are ${amount} projects with an id greater than 25`);

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#maxminandsum)`max`, `min` and `sum`

Sequelize also provides the `max`, `min` and `sum` convenience methods.

Let's assume we have three users, whose ages are 10, 5, and 40.

```
await User.max('age'); // 40
await User.max('age', { where: { age: { [Op.lt]: 20 } } }); // 10
await User.min('age'); // 5
await User.min('age', { where: { age: { [Op.gt]: 5 } } }); // 10
await User.sum('age'); // 55
await User.sum('age', { where: { age: { [Op.gt]: 5 } } }); // 50

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#incrementdecrement)`increment`, `decrement`

Sequelize also provides the `increment` convenience method.

Let's assume we have a user, whose age is 10.

```
await User.increment({age: 5}, { where: { id: 1 } }) // Will increase age to 15
await User.increment({age: -5}, { where: { id: 1 } }) // Will decrease age to 5

```

Generated by [ESDoc(1.1.0)](https://esdoc.org/)

[Raw](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc/raw/da71939ecd2d58ac46542b78874cfd62f955c502/sequelize-getting-started.md)

[sequelize-getting-started.md](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#file-sequelize-getting-started-md)

# [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#getting-started)Getting Started

In this tutorial you will learn to make a simple setup of Sequelize.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#installing)Installing

Sequelize is available via [npm](https://www.npmjs.com/package/sequelize) (or [yarn](https://yarnpkg.com/package/sequelize)).

```
npm install --save sequelize

```

You'll also have to manually install the driver for your database of choice:

```
# One of the following:
$ npm install --save pg pg-hstore # Postgres
$ npm install --save mysql2
$ npm install --save mariadb
$ npm install --save sqlite3
$ npm install --save tedious # Microsoft SQL Server

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#connecting-to-a-database)Connecting to a database

To connect to the database, you must create a Sequelize instance. This can be done by either passing the connection parameters separately to the Sequelize constructor or by passing a single connection URI:

```
const { Sequelize } = require('sequelize');

// Option 1: Passing a connection URI
const sequelize = new Sequelize('sqlite::memory:') // Example for sqlite
const sequelize = new Sequelize('postgres://user:pass@example.com:5432/dbname') // Example for postgres

// Option 2: Passing parameters separately (sqlite)
const sequelize = new Sequelize({
  dialect: 'sqlite',
  storage: 'path/to/database.sqlite'
});

// Option 3: Passing parameters separately (other dialects)
const sequelize = new Sequelize('database', 'username', 'password', {
  host: 'localhost',
  dialect: /* one of 'mysql' | 'mariadb' | 'postgres' | 'mssql' */
});

```

The Sequelize constructor accepts a lot of options. They are documented in the [API Reference](https://sequelize.org/master/class/lib/sequelize.js~Sequelize.html#instance-constructor-constructor).

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#testing-the-connection)Testing the connection

You can use the `.authenticate()` function to test if the connection is OK:

```
try {
  await sequelize.authenticate();
  console.log('Connection has been established successfully.');
} catch (error) {
  console.error('Unable to connect to the database:', error);
}

```

### [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#closing-the-connection)Closing the connection

Sequelize will keep the connection open by default, and use the same connection for all queries. If you need to close the connection, call `sequelize.close()` (which is asynchronous and returns a Promise).

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#terminology-convention)Terminology convention

Observe that, in the examples above, `Sequelize` refers to the library itself while `sequelize` refers to an instance of Sequelize, which represents a connection to one database. This is the recommended convention and it will be followed throughout the documentation.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#tip-for-reading-the-docs)Tip for reading the docs

You are encouraged to run code examples locally while reading the Sequelize docs. This will help you learn faster. The easiest way to do this is using the SQLite dialect:

```
const { Sequelize, Op, Model, DataTypes } = require("sequelize");
const sequelize = new Sequelize("sqlite::memory:");

// Code here! It works!

```

To experiment with the other dialects, which are harder to setup locally, you can use the [Sequelize SSCCE](https://github.com/papb/sequelize-sscce) GitHub repository, which allows you to run code on all supported dialects directly from GitHub, for free, without any setup!

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#new-databases-versus-existing-databases)New databases versus existing databases

If you are starting a project from scratch, and your database is still empty, Sequelize can be used since the beginning in order to automate the creation of every table in your database.

Also, if you want to use Sequelize to connect to a database that is already filled with tables and data, that works as well! Sequelize has got you covered in both cases.

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#logging)Logging

By default, Sequelize will log to console every SQL query it performs. The `options.logging` option can be used to customize this behavior, by defining the function that gets executed every time Sequelize would log something. The default value is `console.log` and when using that only the first log parameter of log function call is displayed. For example, for query logging the first parameter is the raw query and the second (hidden by default) is the Sequelize object.

Common useful values for `options.logging`:

```
const sequelize = new Sequelize('sqlite::memory:', {
  // Choose one of the logging options
  logging: console.log,                  // Default, displays the first parameter of the log function call
  logging: (...msg) => console.log(msg), // Displays all log function call parameters
  logging: false,                        // Disables logging
  logging: msg => logger.debug(msg),     // Use custom logger (e.g. Winston or Bunyan), displays the first parameter
  logging: logger.debug.bind(logger)     // Alternative way to use custom logger, displays all messages
});

```

## [](https://gist.github.com/bgoonz/a86e8a334a332aaa6250094fbfb095cc#promises-and-asyncawait)Promises and async/await

Most of the methods provided by Sequelize are asynchronous and therefore return Promises. They are all [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) , so you can use the Promise API (for example, using `then`, `catch`, `finally`) out of the box.

Of course, using `async` and `await` works normally as well.
