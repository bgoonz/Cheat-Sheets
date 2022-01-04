---
title: ExpressJS Cheat Sheet
excerpt: ' Node.js is an open-source and cross-platform JavaScript runtime environment. It is a popular tool for almost any kind of project!  Node.js runs the V8 JavaScript engine, the core of Google Chrome, outside of the browser. This allows Node.js to be very performant.  A Node.js app runs in a single process, without creating a new thread for every request. Node.js provides a set of asynchronous I/O primitives in its standard library that prevent JavaScript code from blocking and generally, libraries in Node.js are written using non-blocking paradigms, making blocking behavior the exception rather than the norm.  When Node.js performs an I/O operation, like reading from the network, accessing a database or the filesystem, instead of blocking the thread and wasting CPU cycles waiting, Node.js will resume the operations when the response comes back.  This allows Node.js to handle thousands of concurrent connections with a single server without introducing the burden of managing thread concurrency, which could be a significant source of bugs.  Node.js has a unique advantage because millions of frontend developers that write JavaScript for the browser are now able to write the server-side code in addition to the client-side code without the need to learn a completely different language.  In Node.js the new ECMAScript standards can be used without problems, as you don''t have to wait for all your users to update their browsers - you are in charge of deciding which ECMAScript version to use by changing the Node.js version, and you can also enable specific experimental features by running Node.js with flags.  ## [](https://nodejs.dev/learn#a-vast-number-of-libraries)A Vast Number of Libraries  npm with its simple structure helped the ecosystem of Node.js proliferate, and now the npm registry hosts over 1,000,000 open source packages you can freely use.  ## [](https://nodejs.dev/learn#an-example-nodejs-application)An Example Node.js Application  The most common example Hello World of Node.js is a web server:  This code first includes the Node.js [`http` module](https://nodejs.org/api/http.html).  Node.js has a fantastic [standard library](https://nodejs.org/api/), including first-class support for networking.  The `createServer()` method of `http` creates a new HTTP server and returns it.  The server is set to listen on the specified port and host name. When the server is ready, the callback function is called, in this case informing us that the server is running.  Whenever a new request is received, the [`request` event](https://nodejs.org/api/http.html#http_event_request) is called, providing two objects: a request (an [`http.IncomingMessage`](https://nodejs.org/api/http.html#http_class_http_incomingmessage) object) and a response (an [`http.ServerResponse`](https://nodejs.org/api/http.html#http_class_http_serverresponse) object).  Those 2 objects are essential to handle the HTTP call.  The first provides the request details. In this simple example, this is not used, but you could access the request headers and request data.  The second is used to return data to the caller.  In this case with:  JS  res.statusCode \= 200  we set the statusCode property to 200, to indicate a successful response.  We set the Content-Type header:  JS  res.setHeader(''Content-Type'', ''text/plain'')  and we close the response, adding the content as an argument to `end()`:  JS  res.end(''Hello World\\n'')  Node.js is a low-level platform. In order to make things easy and exciting for developers, thousands of libraries were built upon Node.js by the community.  Many of those established over time as popular options. Here is a non-comprehensive list of the ones worth learning:  -   [**AdonisJS**](https://adonisjs.com/): A TypeScript-based fully featured framework highly focused on developer ergonomics, stability, and confidence. Adonis is one of the fastest Node.js web frameworks. -   [**Egg.js**](https://eggjs.org/en/): A framework to build better enterprise frameworks and apps with Node.js & Koa. -   [**Express**](https://expressjs.com/): It provides one of the most simple yet powerful ways to create a web server. Its minimalist approach, unopinionated, focused on the core features of a server, is key to its success. -   [**Fastify**](https://fastify.io/): A web framework highly focused on providing the best developer experience with the least overhead and a powerful plugin architecture. Fastify is one of the fastest Node.js web frameworks. -   [**FeatherJS**](https://feathersjs.com/): Feathers is a lightweight web-framework for creating real-time applications and REST APIs using JavaScript or TypeScript. Build prototypes in minutes and production-ready apps in days. -   [**Gatsby**](https://www.gatsbyjs.com/): A [React](https://reactjs.org/)\-based, [GraphQL](https://graphql.org/) powered, static site generator with a very rich ecosystem of plugins and starters. -   [**hapi**](https://hapijs.com/): A rich framework for building applications and services that enables developers to focus on writing reusable application logic instead of spending time building infrastructure. -   [**koa**](http://koajs.com/): It is built by the same team behind Express, aims to be even simpler and smaller, building on top of years of knowledge. The new project born out of the need to create incompatible changes without disrupting the existing community. -   [**Loopback.io**](https://loopback.io/): Makes it easy to build modern applications that require complex integrations. -   [**Meteor**](https://meteor.com/): An incredibly powerful full-stack framework, powering you with an isomorphic approach to building apps with JavaScript, sharing code on the client and the server. Once an off-the-shelf tool that provided everything, now integrates with frontend libs [React](https://reactjs.org/), [Vue](https://vuejs.org/), and [Angular](https://angular.io/). Can be used to create mobile apps as well. -   [**Micro**](https://github.com/zeit/micro): It provides a very lightweight server to create asynchronous HTTP microservices. -   [**NestJS**](https://nestjs.com/): A TypeScript based progressive Node.js framework for building enterprise-grade efficient, reliable and scalable server-side applications. -   [**Next.js**](https://nextjs.org/): [React](https://reactjs.org/) framework that gives you the best developer experience with all the features you need for production: hybrid static & server rendering, TypeScript support, smart bundling, route pre-fetching, and more. -   [**Nx**](https://nx.dev/): A toolkit for full-stack monorepo development using NestJS, Express, [React](https://reactjs.org/), [Angular](https://angular.io/), and more! Nx helps scale your development from one team building one application to many teams collaborating on multiple applications! -   [**Sapper**](https://sapper.svelte.dev/): Sapper is a framework for building web applications of all sizes, with a beautiful development experience and flexible filesystem-based routing. Offers SSR and more! -   [**Socket.io**](https://socket.io/): A real-time communication engine to build network applications. -   [**Strapi**](https://strapi.io/): Strapi is a flexible, open-source Headless CMS that gives developers the freedom to choose their favorite tools and frameworks while also allowing editors to easily manage and distribute their content. By making the admin panel and API extensible through a plugin system, Strapi enables the world''s largest companies to accelerate content delivery while building beautiful digital experiences.'
date: '2022-01-04'
thumb_img_path: images/jquery-be370939.png
thumb_img_alt: expressjs
content_img_path: images/node-express-a1f4367f.png
content_img_alt: expressjs
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
