---
title: ExpressJS Cheat Sheet
excerpt: >-
  Miyagi Zao Fox Village, aka Kitsune Mura, is a popular tourist attraction
  situated in Shiroishi, Miyagi it based in the Miyagi Zao mountains. Visitors
  can visit a village where there is a vast population of foxes.
date: '2022-01-04'
thumb_img_path: images/jquery-be370939.png
thumb_img_alt: expressjs
content_img_path: images/5.jpg
content_img_alt: A red fox in a rocky forest
seo:
  title: ExpressJS Cheat Sheet
  description: >-
    Apparently, Japan is covered in magical and irresistibly cute animal
    sanctuaries.
  extra:
    - name: 'og:type'
      value: article
      keyName: property
    - name: 'og:title'
      value: ExpressJS Cheat Sheet
      keyName: property
    - name: 'og:description'
      value: >-
        Apparently, Japan is covered in magical and irresistibly cute animal
        sanctuaries.
      keyName: property
    - name: 'og:image'
      value: images/5.jpg
      keyName: property
      relativeUrl: true
    - name: 'twitter:card'
      value: summary_large_image
    - name: 'twitter:title'
      value: ExpressJS Cheat Sheet
    - name: 'twitter:description'
      value: >-
        Apparently, Japan is covered in magical and irresistibly cute animal
        sanctuaries.
    - name: 'twitter:image'
      value: images/5.jpg
      relativeUrl: true
template: post
subtitle: >-
  Express.js, or simply Express, is a back end web application framework for
  Node.js, released as free and open-source software under the MIT License. It
  is designed for building web applications and APIs. It has been called the de
  facto standard server
---

## Background:

# Installing

Assuming you've already installed [Node.js](https://nodejs.org/), create a directory to hold your application, and make that your working directory.

```
$ mkdir myapp
$ cd myapp

```

Use the `npm init` command to create a `package.json` file for your application. For more information on how `package.json` works, see [Specifics of npm's package.json handling](https://docs.npmjs.com/files/package.json).

```
$ npm init

```

This command prompts you for a number of things, such as the name and version of your application. For now, you can simply hit RETURN to accept the defaults for most of them, with the following exception:

```
entry point: (index.js)

```

Enter `app.js`, or whatever you want the name of the main file to be. If you want it to be `index.js`, hit RETURN to accept the suggested default file name.

Now install Express in the `myapp` directory and save it in the dependencies list. For example:

```
$ npm install express --save

```

To install Express temporarily and not add it to the dependencies list:

```
$ npm install express --no-save

```

By default with version npm 5.0+ npm install adds the module to the `dependencies` list in the `package.json` file; with earlier versions of npm, you must specify the `--save` option explicitly. Then, afterwards, running `npm install` in the app directory will automatically install modules in the dependencies list.

# Express Cheatsheet

- [Installing](#installing)
- [Express Cheatsheet](#express-cheatsheet)
  - [Creating an App](#creating-an-app)
  - [Listening on a port](#listening-on-a-port)
    - [Using a separate server instance](#using-a-separate-server-instance)
  - [Middleware](#middleware)
    - [Standard middleware function signature](#standard-middleware-function-signature)
    - [`app.use`](#appuse)
    - [Routes - `app.get`, `app.post`, etc](#routes---appget-apppost-etc)
    - [Router](#router)
      - [Making a new router](#making-a-new-router)
      - [Letting app know about the router and it's prefix.](#letting-app-know-about-the-router-and-its-prefix)
      - [Defining Routes on the Router](#defining-routes-on-the-router)
  - [Error handling](#error-handling)
  - [Common Pitfalls](#common-pitfalls)
    - [Not sending anything back from a route](#not-sending-anything-back-from-a-route)

## Creating an App

```js
const express = require("express");
const app = express();
```

## Listening on a port

```js
const PORT = 4000;

app.listen(PORT, () => {
  console.log(`Listening on ${PORT}`);
});
```

### Using a separate server instance

Sometimes you may want to separate the app from the server itself.

This makes testing easier, and is a good separation of concerns.

```js
// In server.js
const http = require('http'); // This is node's built-in http module
const app = require('./app'); // Assuming we create our app in app.js

const server = http.createServer(app); // We can pass the app to createServer

server.listen(PORT, () => {
    console.log(`Listening on ${PORT`}`);
});
```

## Middleware

Every callback we define in express is middleware.

### Standard middleware function signature

```js
(req, res, next) => {};
```

- `req` - The Request object that represents the incoming Request to the server
- `res` - The Response object that represents the outgoing response to the browser
- `next` - A function that will move to the next middleware function in the chain

### `app.use`

`app.use` is how you register a middleware function with express. Functions are added
to the express app in the order the `app.use()` functions are invoked. The callback
(middleware) functions aren't called until a new request comes in to the server.

```js
app.use((req, res, next) => {
  // this runs when a request comes in.
});
```

`app.use` can accept a list of middleware functions OR an array of them.

```js
// Two arrow functions.
app.use(
  (req, res, next) => {},
  (req, res, next) => {}
);

// Two named functions.
app.use(middleware1, middleware2);

// An array of middleware functions
app.use([middleware1, middleware2]);

// Or any combination. It's flexible!
app.use([middleware1, middleware2], middleware3, (req, res, next) => {});
```

The important thing is, you are just giving express function _references_, the
functions do not get called _until a request is made to the server_.

### Routes - `app.get`, `app.post`, etc

Express routes are similar to app.use, but are _conditional_ middleware.

They depend on the HTTP Method and the Path matching in order to run.

The first argument to these routes is the path to match.

```js
app.get("/", (req, res, next) => {
  // Runs only for a GET request to /
});

app.post("/users", (req, res, next) => {
  // Runs only for a POST request to /users
});
```

### Router

As a way of organizing your router, express includes a router object.

#### Making a new router

```jsx
const express = require("express");
const userRouter = express.Router();
```

#### Letting app know about the router and it's prefix.

We can use `app.use` to tell express about the router and what _prefix_
all of it's routes will be under.

```js
const app = express();
const userRouter = express.Router();

// every route we create on userRouter will have the prefix `/users`
app.use("/users", userRouter);
```

#### Defining Routes on the Router

Routers contain the same `.use()` `.get()` and `.post()` methods that `app` does.
However, the path matching matches everything _after_ the router's prefix.

```js
// Passing a middleware to the router
userRouter.use(middleware);

userRouter.get("/profile", (req, res, next) => {
  // Runs when the router path matches /profile
  // excluding the prefix
  // Example: If the userRouter's prefix was /users
  // then the full path that matches is /users/profile
});
```

## Error handling

Error handling middleware is just like regular middleware but has _four_ parameters
to the callback function.

Make sure you log your errors to the console, otherwise if you have a bug in your
express app, it might be completely hidden from you.

```js
app.use((err, req, res, next) => {
  // The first argument will be an error.
  console.error(err); // This is a good idea
});
```

## Common Pitfalls

### Not sending anything back from a route

This will cause express to hang forever. Your browser will never get a response.

```js
app.get("/", (req, res, next) => {
  // if I don't res.send or res.json
  // And I don't call next()
  // This will cause express to hang.
});
```
