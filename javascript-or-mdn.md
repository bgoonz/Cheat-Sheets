# JavaScript





```js

customArrayProp: PropTypes.arrayOf(function(propValue, key, componentName, location, propFullName) {
  if (!/matchme/.test(propValue[key])) {
    return new Error(
      'Invalid prop `' + propFullName + '` supplied to' +
      ' `' + componentName + '`. Validation failed.'
    );
  }
})
};
```

***

> current item's key.

> arguments of the validator are the array or object itself, and the

> will be called for each key in the array or object. The first two

> It should return an Error object if the validation fails. The validator

#### You can also supply a custom validator to `arrayOf` and `objectOf`

***

```js

customProp: function(props, propName, componentName) {
  if (!/matchme/.test(props[propName])) {
    return new Error(
      'Invalid prop `' + propName + '` supplied to' +
      ' `' + componentName + '`. Validation failed.'
    );
  }
},

```

***

> won't work inside `oneOfType`.

> object if the validation fails. Don't `console.warn` or throw, as this

* requiredFunc: PropTypes.func.isRequired, A value of any data type
* requiredAny: PropTypes.any.isRequired, You can also specify a custom validator. It should return an Error

#### is shown if the prop isn't provided

***

```js

optionalEnum: PropTypes.oneOf(['News', 'Photos']),  An object that could be one of many types
optionalUnion: PropTypes.oneOfType([
  PropTypes.string,
  PropTypes.number,
  PropTypes.instanceOf(Message)
]),  An array of a certain type
optionalArrayOf: PropTypes.arrayOf(PropTypes.number),  An object with property values of a certain type
optionalObjectOf: PropTypes.objectOf(PropTypes.number),  An object taking on a particular shape
optionalObjectWithShape: PropTypes.shape({
  color: PropTypes.string,
  fontSize: PropTypes.number
}),  You can chain any of the above with `isRequired` to make sure a warning

```

***

> it as an enum.

optionalMessage: PropTypes.instanceOf(Message), You can ensure that your prop is limited to specific values by treating

> JS's instanceof operator.

#### optionalElement: PropTypes.element, You can also declare that a prop is an instance of a class. This uses

***

optionalNode: PropTypes.node, A React element.

#### (or fragment) containing these types

***

```js

optionalArray: PropTypes.array,
optionalBool: PropTypes.bool,
optionalFunc: PropTypes.func,
optionalNumber: PropTypes.number,
optionalObject: PropTypes.object,
optionalString: PropTypes.string,
optionalSymbol: PropTypes.symbol,  Anything that can be rendered: numbers, strings, elements or an array
```

**You can declare that a prop is a specific JS type. By default, these are all optional**

***

```js

ReactDOMServer.renderToStaticNodeStream(element)

import PropTypes from 'prop-types';
MyComponent.propTypes = {
```

***

> page generator, as stripping away the extra attributes can save some bytes.

> internally, such as data-reactroot. This is useful if you want to use React as a simple static

#### Similar to renderToNodeStream, except this doesn't create extra DOM attributes that React uses

***

```js
ReactDOMServer.renderToNodeStream(element);
```

***

> request for faster page loads and to allow search engines to crawl your pages for SEO purposes.

**You can use this method to generate HTML on the server and send the markup down on the initial**

***

> The HTML output by this stream is exactly equal to what ReactDOMServer.renderToString would return.

#### Render a React element to its initial HTML. Returns a Readable stream that outputs an HTML string

***

```js
ReactDOMServer.renderToStaticMarkup(element);
```

***

> page generator, as stripping away the extra attributes can save some bytes.

> internally, such as data-reactroot. This is useful if you want to use React as a simple static

#### Similar to renderToString, except this doesn't create extra DOM attributes that React uses

***

```js
ReactDOMServer.renderToString(element);
```

***

> request for faster page loads and to allow search engines to crawl your pages for SEO purposes.

**You can use this method to generate HTML on the server and send the markup down on the initial**

***

> Render a React element to its initial HTML. React will return an HTML string.

* The ReactDOMServer object enables you to render components to static markup.

## REACTDOMSERVER

***

***

***

***

```js
ReactDOM.createPortal(child, container);
```

***

***

> the hierarchy of the DOM component.

#### Creates a portal. Portals provide a way to render children into a DOM node that exists outside

***

```js
ReactDOM.findDOMNode(component);
```

***

> using findDOMNode at all.

> and performing DOM measurements. In most cases, you can attach a ref to the DOM node and avoid

> DOM element. This method is useful for reading values out of the DOM, such as form field values

#### If this component has been mounted into the DOM, this returns the corresponding native browser

***

```js
ReactDOM.unmountComponentAtNode(container);
```

***

> Returns true if a component was unmounted and false if there was no component to unmount.

> If no component was mounted in the container, calling this function does nothing.

#### Remove a mounted React component from the DOM and clean up its event handlers and state

***

```js

ReactDOM.hydrate(element, container[, callback]);
```

***

> by ReactDOMServer. React will attempt to attach event listeners to the existing markup.

#### Same as render(), but is used to hydrate a container whose HTML contents were rendered

***

```js

ReactDOM.render(element, container[, callback]);
```

***

> to the component (or returns null for stateless components).

> Render a React element into the DOM in the supplied container and return a reference

* The react-dom package provides DOM-specific methods that can be used at the top level of
* your app and as an escape hatch to get outside of the React model if you need to.
* Most of your components should not need to use this module.

## REACT.DOM

***

***

***

***

```js
component.forceUpdate(callback);
```

***

> Normally you should try to avoid all uses of forceUpdate() and only read from this.props and this.state in render().

> If your render() method depends on some other data, you can tell React that the component needs re-rendering by calling forceUpdate().

#### By default, when your component's state or props change, your component will re-render

***

```js
Component.defaultProps = {
  color: "blue",
};
component = new Component();
```

***

> This is used for undefined props, but not for null props.

> Can be defined as a property on the component class itself, to set the default props for the class.

***

```js

  console.log(this.state);
  return (
    <div>
      {/* Comment goes here */}
      Hello, {this.props.name}!
    </div>
  );
}
}
```

***

> Treat this.state as if it were immutable.

> Never mutate this.state directly, as calling setState() afterwards may replace the mutation you made.

> For example, you can put timer IDs directly on the instance.

> If you don't use it in render(), it shouldn't be in the state.

> The state is user-defined, and it should be a plain JavaScript object.

#### Contains data specific to this component that may change over time

***

```js
console.log(this.props);
```

***

> Contains the props that were defined by the caller of this component.

```js

render() {
```

***

> It must return one of the following types: react elements, string and numbers, portals, null or booleans.

> it does not directly interact with the browser (use lifecycle methods for this)

> It should be pure, meaning that it does not modify component state, it returns the same result each time it's invoked, and

> This method is required.

```js

componentDidCatch() { }
```

***

> Error boundaries catch errors during rendering, in lifecycle methods, and in constructors of the whole tree below them.

> Error boundaries are React components that catch JavaScript errors anywhere in their child component tree, log those errors, and display a fallback UI instead of the component tree that crashed.

```js

componentWillUnmount() { }
```

***

> Perform any necessary cleanup in this method, such as invalidating timers, canceling network requests, or cleaning up any subscriptions that were created in componentDidMount().

> Invoked immediately before a component is unmounted and destroyed.

```js

componentDidUpdate(prevProps, prevState) { }
```

***

> This is also a good place to do network requests as long as you compare the current props to previous props (e.g. a network request may not be necessary if the props have not changed).

> Use this as an opportunity to operate on the DOM when the component has been updated.

> Invoked immediately after updating occurs. This method is not called for the initial render.

```js
componentWillUpdate(nextProps, nextState) { }
```

***

> If you need to update state in response to props changes, use componentWillReceiveProps() instead.

> (e.g. dispatch a Redux action) that would trigger an update to a React component before componentWillUpdate() returns.

> Note that you cannot call this.setState() here; nor should you do anything else

> Use this as an opportunity to perform preparation before an update occurs. This method is not called for the initial render.

> Invoked just before rendering when new props or state are being received.

```js

shouldComponentUpdate(nextProps, nextState) { }
```

***

> Returning false does not prevent child components from re-rendering when their state changes.

> This method is not called for the initial render or when forceUpdate() is used.

#### shouldComponentUpdate() is invoked before rendering when new props or state are being received. Defaults to true

***

> The default behavior is to re-render on every state change, and in the vast majority of cases you should rely on the default behavior.

#### ^^^^ Let React know if a component's output is not affected by the current change in state or props

***

```js

componentWillReceiveProps(nextProps) { }
```

***

> If you need to update the state in response to prop changes (for example, to reset it), you may compare this.props and nextProps and perform state transitions using this.setState() in this method.

> Invoked before a mounted component receives new props.

```js

componentDidMount() { }
```

***

> This method is a good place to set up any subscriptions. If you do that, don't forget to unsubscribe in componentWillUnmount().

> If you need to load data from a remote endpoint, this is a good place to instantiate the network request.

> Initialization that requires DOM nodes should go here.

> Invoked immediately after a component is mounted.

```js

componentWillMount() { }
```

***

> This is the only lifecycle hook called on server rendering.

> Invoked just before mounting occurs (before render())

```jsx

setState(updater[, callback]) { }
```

**You may optionally pass an object as the first argument to setState() instead of a function**

***

> Instead, use componentDidUpdate or a setState callback.

> This makes reading this.state right after calling setState() a potential pitfall.

> setState() does not always immediately update the component. It may batch or defer the update until later.

> Enqueues changes to the component state and tells React that this component and its children need to be re-rendered with the updated state.

```js

    color: props.initialColor
  };
}
```

***

> If you "fork" props by using them for state, you might also want to implement componentWillReceiveProps(nextProps) to keep the state up-to-date with them. But lifting state up is often easier and less bug-prone.

> This effectively "forks" the props and sets the state with the initial props.

#### In rare cases, it's okay to initialize state based on props

***

```js

  this.state = {
    active: true,
```

#### The constructor is the right place to initialize state

***

```js
this.method = this.method.bind(this);
```

> Binding makes sure the method has access to component attributes like this.props and this.state

> The constructor is also often used to bind event handlers to the class instance.

> Will be called before it is mounted constructor(props) { Call this method before any other statement or this.props will be undefined in the constructor super(props);

```js




class Component extends React.Component {
```

**You can also use it with the shorthand <>\</> syntax**

***

#### The React.Fragment component lets you return multiple elements in a render() method without creating an additional DOM element

***

```js
React.Children.toArray(children);
```

***

> Useful if you want to manipulate collections of children in your render methods, especially if you want to reorder or slice this.props.children before passing it down.

#### Returns the children opaque data structure as a flat array with keys assigned to each child

***

```js
React.Children.only(children);
```

***

> Otherwise this method throws an error.

#### Verifies that children has only one child (a React element) and returns it

***

```js
React.Children.count(children);
```

#### Returns the total number of components in children, equal to the number of times that a callback passed to map or forEach would be invoked

***

```js

React.Children.forEach(children, function[(thisArg)]);
```

#### Like React.Children.map() but does not return an array

***

```js

React.Children.map(children, function[(thisArg)]);
```

***

> Invokes a function on every immediate child contained within children with this set to thisArg.

#### React.Children> provides utilities for dealing with the this.props.children opaque data structure

***

```js
React.isValidElement(object);
```

#### Verifies the object is a React element. Returns true or false

***

```js
React.cloneElement(element, [props], [...children]);
```

***

> The resulting element will have the original element's props with the new props merged in shallowly.

#### Clone and return a new React element using element as the starting point

***

```js
React.createElement(type, [props], [...children]);
```

**You will not typically invoke React.createElement() directly if you are using JSX**

***

> Code written with JSX will be converted to use React.createElement().

> Create and return a new React element of the given type.

### notes: don't forget the command lines

```bash

npm install --save react
#// declarative and flexible JavaScript library for building UI
npm install --save react-dom
---
---
---
---


#> serves as the entry point of the DOM-related rendering paths
npm install --save prop-types
#// runtime type checking for React props and similar objects
```

***

## ReactJS

***

***

***

***

```js
```

#### How many bytes will be returned when buffer.inspect() is called. This can be overridden by user modules

***

```js
buffer.INSPECT_MAX_BYTES;
```

#### The size of the buffer in bytes, Note that this is not necessarily the size of the contents

***

```js
buf.length;
```

#### Get and set the octet at index

***

```js
buf[index];
```

#### Fills the buffer with the specified value

***

```js
buf.fill(value, [offset], [end]);
```

#### Returns a new buffer which references the same memory as the old, but offset and cropped by the start (defaults to 0) and end (defaults to buffer.length) indexes. Negative indexes start from the end of the buffer

***

```js
buf.slice([start], [end]);
```

#### Does copy between buffers. The source and target regions can be overlapped

***

***

```js
buf.copy(targetBuffer, [targetStart], [sourceStart], [sourceEnd]);
```

#### Returns a JSON-representation of the Buffer instance, which is identical to the output for JSON Arrays

***

```js
buf.toJSON();
```

***

> Decodes and returns a string from buffer data encoded with encoding (defaults to 'utf8') beginning at start (defaults to 0) and ending at end (defaults to buffer.length).

***

> buf.toString(\[encoding], \[start], \[end]);

#### Writes string to the buffer at offset using the given encoding

***

```js
buf.write(string, [offset], [length], [encoding]);
```

#### Gives the actual byte length of a string

***

```js
Buffer.byteLength(string, [encoding]);
```

#### Returns a buffer which is the result of concatenating all the buffers in the list together

***

```js
Buffer.concat(list, [totalLength]);
```

#### Tests if obj is a Buffer

***

```js
Buffer.isBuffer(obj);
```

#### Returns true if the encoding is a valid encoding argument, or false otherwise

***

```js
Buffer.isEncoding(encoding);
```

#### Allocates a new buffer containing the given str. encoding defaults to 'utf8'

***

```js
Buffer.from(str, [encoding]);
```

#### Allocates a new buffer using an array of octets

***

```js
Buffer.from(array);
```

#### Allocates a new buffer of size octets

***

```js
Buffer.from(size);
```

> Buffer is used to dealing with binary data Buffer is similar to an array of integers but corresponds to a raw memory allocation outside the V8 heap

#### A constant defining the appropriate End-of-line marker for the operating system

***

```js
os.EOL;
```

#### Get a list of network interfaces

***

***

```js
os.networkInterfaces();
```

#### Returns an array of objects containing information about each CPU/core installed: model, speed (in MHz), and times (an object containing the number of milliseconds the CPU/core spent in: user, nice, sys, idle, and irq)

***

```js
os.cpus();
```

#### Returns the amount of free system memory in bytes

***

***

```js
os.freemem();
```

#### Returns the total amount of system memory in bytes

***

```js
os.totalmem();
```

#### Returns an array containing the 1, 5, and 15 minute load averages

***

***

```js
os.loadavg();
```

#### Returns the system uptime in seconds

***

```js
os.uptime();
```

#### Returns the operating system release

***

***

```js
os.release();
```

#### Returns the operating system CPU architecture

***

```js
os.arch();
```

#### Returns the operating system platform

***

```js
os.platform();
```

#### Returns the operating system name

***

```js
os.type();
```

#### Returns the hostname of the operating system

***

```js
os.hostname();
```

#### Returns the endianness of the CPU. Possible values are "BE" or "LE"

***

```js
os.endianness();
```

#### Returns the operating system's default directory for temp files

***

```js
os.tmpdir();
```

***

> Use require('os') to access this module.

> Provides a few basic operating-system related utility functions.

#### Tests if value is not a false value, throws if it is a true value. Useful when testing the first argument, error in callbacks

***

```js
assert.ifError(value);
```

#### Expects block not to throw an error, see assert.throws for details

***

```js
assert.doesNotThrow(block, [message]);
```

#### Expects block to throw an error. error can be constructor, RegExp or validation function

***

```js
assert.throws(block, [error], [message]);
```

#### Tests strict non-equality, as determined by the strict not equal operator ( !== )

***

```js
assert.notStrictEqual(actual, expected, [message]);
```

#### Tests strict equality, as determined by the strict equality operator ( === )

***

***

```js
assert.strictEqual(actual, expected, [message]);
```

#### Tests for any deep inequality

***

```js
assert.notDeepEqual(actual, expected, [message]);
```

#### Tests for deep equality

***

```js
assert.deepEqual(actual, expected, [message]);
```

#### Tests shallow, coercive non-equality with the not equal comparison operator ( != )

***

```js
assert.notEqual(actual, expected, [message]);
```

#### Tests shallow, coercive equality with the equal comparison operator ( == )

***

***

```js
assert.equal(actual, expected, [message]);
```

#### Tests if value is truthy, it is equivalent to assert.equal(true, !!value, message)

***

***

```js
assert(value, message);
assert.ok(value, [message]);
```

#### Throws an exception that displays the values for actual and expected separated by the provided operator

***

```js
assert.fail(actual, expected, message, operator);
```

***

> This module is used for writing unit tests for your applications, you can access it with require('assert').

#### Deserialize a query string to an object. Optionally override the default separator ('&') and assignment ('=') characters

***

***

```js
querystring.parse(str, [sep], [eq], [options]);
```

#### Serialize an object to a query string. Optionally override the default separator ('&') and assignment ('=') characters

***

```js
querystring.stringify(obj, [sep], [eq]);
```

## This module provides utilities for dealing with query strings. Call require('querystring') to use it

***

***

***

***

#### Take a base URL, and a href URL, and resolve them as a browser would for an anchor tag

***

```js
url.resolve(from, to);
```

#### Take a parsed URL object, and return a formatted URL string

***

```js
url.format(urlObj);
```

#### Take a URL string, and return an object

***

***

```js
url.parse(urlStr, [parseQueryString], [slashesDenoteHost]);
```

***

> This module has utilities for URL resolution and parsing. Call require('url') to use it.

#### Calls message.connection.setTimeout(msecs, callback)

***

```js
message.setTimeout(msecs, callback);
```

#### The net.Socket object associated with the connection

***

```js
message.socket;
```

***

> The 3-digit HTTP response status code. E.G. 404.

```js
message.statusCode;
```

#### Request URL string. This contains only the URL that is present in the actual HTTP request

***

```js
message.url;
```

#### The request method as a string. Read only. Example: 'GET', 'DELETE'

***

```js
message.method;
```

#### The request/response trailers object. Only populated after the 'end' event

***

***

```js
message.trailers;
```

#### The request/response headers object

***

```js
message.headers;
```

#### In case of server request, the HTTP version sent by the client. In the case of client response, the HTTP version of the connected-to server

***

```js
message.httpVersion;
```

#### Emitted when the response has been sent

***

***

```js
response.on("finish", function () {});
```

#### Indicates that the underlying connection was terminated before response.end() was called or able to flush

***

***

```js
response.on("close", function () {});
```

#### When true, the Date header will be automatically generated and sent in the response if it is not already present in the headers. Defaults to true

***

```js
response.sendDate;
```

#### Boolean (read-only). True if headers were sent, false otherwise

***

```js
response.headersSent;
```

#### When using implicit headers (not calling response.writeHead() explicitly), this property controls the status code that will be sent to the client when the headers get flushed

***

```js
response.statusCode;
```

#### This method signals to the server that all of the response headers and body have been sent; that server should consider this message complete. The method, response.end(), MUST be called on each response

***

```js
response.end([data], [encoding]);
```

#### This method adds HTTP trailing headers (a header but at the end of the message) to the response

***

```js
response.addTrailers(headers);
```

#### Removes a header that's queued for implicit sending

***

```js
response.removeHeader(name);
```

#### Reads out a header that's already been queued but not sent to the client. Note that the name is case insensitive

***

```js
response.getHeader(name);
```

#### Sets a single header value for implicit headers. If this header already exists in the to-be-sent headers, its value will be replaced. Use an array of strings here if you need to send multiple headers with the same name

***

```js
response.setHeader(name, value);
```

#### Sets the Socket's timeout value to msecs. If a callback is provided, then it is added as a listener on the 'timeout' event on the response object

***

```js
response.setTimeout(msecs, callback);
```

#### Sends a response header to the request

***

```js
response.writeHead(statusCode, [reasonPhrase], [headers]);
```

#### Sends a HTTP/1.1 100 Continue message to the client, indicating that the request body should be sent

***

```js
response.writeContinue();
```

#### This sends a chunk of the response body. If this merthod is called and response.writeHead() has not been called, it will switch to implicit header mode and flush the implicit headers

***

```js
response.write(chunk, [encoding]);
```

#### Emitted when the server sends a '100 Continue' HTTP response, usually because the request contained 'Expect: 100-continue'. This is an instruction that the client should send the request body

***

```js
request.on("continue", function () {});
```

#### Emitted each time a server responds to a request with an upgrade. If this event isn't being listened for, clients receiving an upgrade header will have their connections closed

***

```js
request.on("upgrade", function (response, socket, head) {});
```

#### Emitted each time a server responds to a request with a CONNECT method. If this event isn't being listened for, clients receiving a CONNECT method will have their connections closed

***

```js
request.on("connect", function (response, socket, head) {});
```

#### Emitted after a socket is assigned to this request

***

```js
request.on("socket", function (socket) {});
```

#### Emitted when a response is received to this request. This event is emitted only once

***

```js
request.on("response", function (response) {});
```

#### Once a socket is assigned to this request and is connected socket.setKeepAlive() will be called

***

```js
request.setSocketKeepAlive([enable], [initialDelay]);
```

#### Once a socket is assigned to this request and is connected socket.setNoDelay() will be called

***

```js
request.setNoDelay([noDelay]);
```

#### Once a socket is assigned to this request and is connected socket.setTimeout() will be called

***

***

```js
request.setTimeout(timeout, [callback]);
```

#### Aborts a request

***

```js
request.abort();
```

#### Finishes sending the request. If any parts of the body are unsent, it will flush them to the stream

***

```js
request.end([data], [encoding]);
```

#### Sends a chunk of the body

***

```js
request.write(chunk, [encoding]);
```

#### If a client connection emits an 'error' event - it will forwarded here

***

```js
server.on("clientError", function (exception, socket) {});
```

#### Emitted each time a client requests a http upgrade

***

```js
server.on("upgrade", function (request, socket, head) {});
```

#### Emitted each time a client requests a http CONNECT method

***

```js
server.on("connect", function (request, socket, head) {});
```

#### Emitted each time a request with an http Expect: 100-continue is received

***

***

```js
server.on("checkContinue", function (request, response) {});
```

#### Emitted when the server closes

***

***

```js
server.on("close", function () {});
```

#### When a new TCP stream is established

***

```js
server.on("connection", function (socket) {});
```

#### Emitted each time there is a request

***

```js
server.on("request", function (request, response) {});
```

#### The number of milliseconds of inactivity before a socket is presumed to have timed out

***

```js
server.timeout;
```

#### Limits maximum incoming headers count, equal to 1000 by default. If set to 0 - no limit will be applied

***

***

```js
server.maxHeadersCount;
```

#### Sets the timeout value for sockets, and emits a 'timeout' event on the Server object, passing the socket as an argument, if a timeout occurs

***

```js
server.setTimeout(msecs, callback);
```

#### Stops the server from accepting new connections

***

```js
server.close([callback]);
```

#### The handle object can be set to either a server or socket (anything with an underlying \_handle member), or a {fd: } object

***

```js
server.listen(handle, [callback]);
```

#### Start a UNIX socket server listening for connections on the given path

***

```js
server.listen(path, [callback]);
```

#### Begin accepting connections on the specified port and hostname

***

```js
server.listen(port, [hostname], [backlog], [callback]);
```

#### Returns a new web server object. The requestListener is a function which is automatically added to the 'request' event

***

***

```js
server = http.createServer([requestListener]);
```

#### Set the method to GET and calls req.end() automatically

***

```js
http.get(options, [callback]);
```

***

> This function allows one to transparently issue requests.

***

```js
http.request(options, [callback]);
```

#### A collection of all the standard HTTP response status codes, and the short description of each

***

```js
http.STATUS_CODES;
```

***

> To use the HTTP server and client one must require('http').

#### The platform-specific path delimiter, ';' or ':'

***

***

```js
path.delimiter;
```

#### The platform-specific file separator. '\\' or '/'

***

***

```js
path.sep;
```

#### Return the extension of the path, from the last '.' to end of string in the last portion of the path

***

***

```js
path.extname(p);
```

***

> Return the last portion of a path. Similar to the Unix basename command.

```js
path.basename(p, [ext]);
```

#### Return the directory name of a path. Similar to the Unix dirname command

***

```js
path.dirname(p);
```

#### Solve the relative path from 'from' to 'to'

***

```js
path.relative(from, to);
```

#### Resolves 'to' to an absolute path

***

```js

path.resolve([from ...], to);
```

#### Join all arguments together and normalize the resulting path

***

```js

path.join([path1], [path2], [...]);
```

#### Normalize a string path, taking care of '..' and '.' parts

***

```js
path.normalize(p);
```

***

> The file system is not consulted to check whether paths are valid.

> Almost all these methods perform only string transformations.

> This module contains utilities for handling and transforming file paths.

> Use require('path') to use this module.

#### Returns a new WriteStream object

***

***

```js
fs.createWriteStream(path, [options]);
```

#### Returns a new ReadStream object

***

```js

stats.isFile();
stats.isDirectory()
stats.isBlockDevice()
stats.isCharacterDevice()
stats.isSymbolicLink()
>  (only valid with fs.lstat())
stats.isFIFO()
stats.isSocket()
fs.createReadStream(path, [options]);
```

***

> Synchronous version of fs.exists. (should not be used) fs.Stats: objects returned from fs.stat(), fs.lstat() and fs.fstat() and their synchronous counterparts are of this type.

```js
> fs.existsSync(path);
```

#### Test whether or not the given path exists by checking with the file system. Then call the callback argument with either true or false. (should not be used)

***

***

```js
fs.exists(path, callback);
```

#### Watch for changes on filename, where filename is either a file or a directory. The returned object is a fs.FSWatcher. The listener callback gets two arguments (event, filename). event is either 'rename' or 'change', and filename is the name of the file which triggered the event

***

```js
fs.watch(filename, [options], [listener]);
```

#### The synchronous version of fs.appendFile

***

```js
fs.appendFileSync(filename, data, [options]);
```

#### Asynchronously append data to a file, creating the file if it not yet exists. data can be a string or a buffer

***

***

```js
fs.appendFile(filename, data, [options], callback);
```

#### The synchronous version of fs.writeFile

***

```js
fs.writeFileSync(filename, data, [options]);
```

#### Asynchronously writes data to a file, replacing the file if it already exists. data can be a string or a buffer

***

```js
fs.writeFile(filename, data, [options], callback);
```

#### Synchronous version of fs.readFile. Returns the contents of the filename. If the encoding option is specified then this function returns a string. Otherwise it returns a buffer

***

```js
fs.readFileSync(filename, [options]);
```

#### Asynchronously reads the entire contents of a file

***

```js
fs.readFile(filename, [options], callback);
```

#### Synchronous version of fs.read. Returns the number of bytesRead

***

```js
fs.readSync(fd, buffer, offset, length, position);
```

#### Read data from the file specified by fd

***

```js
fs.read(fd, buffer, offset, length, position, callback);
```

#### Synchronous version of fs.write(). Returns the number of bytes written

***

```js
fs.writeSync(fd, buffer, offset, length, position);
```

#### Write buffer to the file specified by fd

***

***

```js
fs.write(fd, buffer, offset, length, position, callback);
```

#### Synchronous fsync

***

```js
fs.fsyncSync(fd);
```

#### Asynchronous fsync. No arguments other than a possible exception are given to the completion callback

***

```js
fs.fsync(fd, callback);
```

#### Synchronous version of fs.futimes()

***

```js
fs.futimesSync(fd, atime, mtime);
```

#### Change the file timestamps of a file referenced by the supplied file descriptor

***

```js
fs.futimes(fd, atime, mtime, callback);
```

#### Synchronous version of fs.utimes()

***

```js
fs.utimesSync(path, atime, mtime);
```

#### Change file timestamps of the file referenced by the supplied path

***

***

```js
fs.utimes(path, atime, mtime, callback);
```

#### Synchronous version of fs.open()

***

```js
fs.openSync(path, flags, [mode]);
```

#### Asynchronous file open

***

```js
fs.open(path, flags, [mode], callback);
```

#### Synchronous close

***

```js
fs.closeSync(fd);
```

#### Asynchronous close. No arguments other than a possible exception are given to the completion callback

***

```js
fs.close(fd, callback);
```

#### Synchronous readdir. Returns an array of filenames excluding '.' and '..'

***

```js
fs.readdirSync(path);
```

#### Asynchronous readdir. Reads the contents of a directory. The callback gets two arguments (err, files) where files is an array of the names of the files in the directory excluding '.' and '..'

***

```js
fs.readdir(path, callback);
```

#### Synchronous mkdir

***

```js
fs.mkdirSync(path, [mode]);
```

#### Asynchronous mkdir. No arguments other than a possible exception are given to the completion callback. mode defaults to 0777

***

```js
fs.mkdir(path, [mode], callback);
```

#### Synchronous rmdir

***

***

```js
fs.rmdirSync(path);
```

#### Asynchronous rmdir. No arguments other than a possible exception are given to the completion callback

***

```js
fs.rmdir(path, callback);
```

## Synchronous realpath. Returns the resolved path

***

```js
fs.realpathSync(path, [cache]);
```

#### Asynchronous realpath. The callback gets two arguments (err, resolvedPath)

***

```js
fs.realpath(path, [cache], callback);
```

#### Synchronous unlink

***

```js
fs.unlinkSync(path);
```

#### Asynchronous unlink. No arguments other than a possible exception are given to the completion callback

***

***

```js
fs.unlink(path, callback);
```

#### Synchronous readlink. Returns the symbolic link's string value

***

***

```js
fs.readlinkSync(path);
```

#### Asynchronous readlink. The callback gets two arguments (err, linkString)

***

```js
fs.readlink(path, callback);
```

#### Synchronous symlink

***

```js
fs.symlinkSync(srcpath, dstpath, [type]);
```

#### Asynchronous symlink. No arguments other than a possible exception are given to the completion callback. The type argument can be set to 'dir', 'file', or 'junction' (default is 'file') and is only available on Windows (ignored on other platforms)

***

***

```js
fs.symlink(srcpath, dstpath, [type], callback);
```

#### Synchronous link

***

```js
fs.linkSync(srcpath, dstpath);
```

#### Asynchronous link. No arguments other than a possible exception are given to the completion callback

***

```js
fs.link(srcpath, dstpath, callback);
```

#### Synchronous fstat. Returns an instance of fs.Stats

***

***

```js
fs.fstatSync(fd);
```

#### Asynchronous fstat. The callback gets two arguments (err, stats) where stats is a fs.Stats object. fstat() is identical to stat(), except that the file to be stat-ed is specified by the file descriptor fd

***

```js
fs.fstat(fd, callback);
```

#### Synchronous lstat. Returns an instance of fs.Stats

***

```js
fs.lstatSync(path);
```

#### Asynchronous lstat. The callback gets two arguments (err, stats) where stats is a fs.Stats object. lstat() is identical to stat(), except that if path is a symbolic link, then the link itself is stat-ed, not the file that it refers to

***

```js
fs.lstat(path, callback);
```

#### Synchronous stat. Returns an instance of fs.Stats

***

```js
fs.statSync(path);
```

#### Asynchronous stat. The callback gets two arguments (err, stats) where stats is a fs.Stats object

***

```js
fs.stat(path, callback);
```

#### Synchronous lchmod

***

```js
fs.lchmodSync(path, mode);
```

#### Asynchronous lchmod. No arguments other than a possible exception are given to the completion callback

***

```js
fs.lchmod(path, mode, callback);
```

#### Synchronous fchmod

***

```js
fs.fchmodSync(fd, mode);
```

#### Asynchronous fchmod. No arguments other than a possible exception are given to the completion callback

***

```js
fs.fchmod(fd, mode, callback);
```

#### Synchronous chmod

***

```js
fs.chmodSync(path, mode);
```

#### Asynchronous chmod. No arguments other than a possible exception are given to the completion callback

***

```js
fs.chmod(path, mode, callback);
```

#### Synchronous lchown

***

```js
fs.lchownSync(path, uid, gid);
```

#### Asynchronous lchown. No arguments other than a possible exception are given to the completion callback

***

```js
fs.lchown(path, uid, gid, callback);
```

#### Synchronous fchown

***

***

```js
fs.fchownSync(fd, uid, gid);
```

#### Asynchronous fchown. No arguments other than a possible exception are given to the completion callback

***

***

```js
fs.fchown(fd, uid, gid, callback);
```

#### Synchronous chown

***

```js
fs.chownSync(path, uid, gid);
```

#### Asynchronous chown. No arguments other than a possible exception are given to the completion callback

***

```js
fs.chown(path, uid, gid, callback);
```

#### Synchronous truncate

***

```js
fs.truncateSync(path, len);
```

#### Asynchronous truncate. No arguments other than a possible exception are given to the completion callback

***

```js
fs.truncate(path, len, callback);
```

#### Synchronous ftruncate

***

```js
fs.ftruncateSync(fd, len);
```

#### Asynchronous ftruncate. No arguments other than a possible exception are given to the completion callback

***

```js
fs.ftruncate(fd, len, callback);
```

#### Synchronous rename

***

```js
fs.renameSync(oldPath, newPath);
```

#### Asynchronous rename. No arguments other than a possible exception are given to the completion callback.Asynchronous ftruncate. No arguments other than a possible exception are given to the completion callback

***

***

```js
fs.rename(oldPath, newPath, callback);
```

***

> All the methods have asynchronous and synchronous forms.

## To use this module do require('fs')

***

***

***

***

> Examples of Transform streams include: zlib streams, crypto streams.

> Transform streams are Duplex streams where the output is in some way computed from the input. They implement both the Readable and Writable interfaces. See above for usage.

> Examples of Duplex streams include: tcp sockets, zlib streams, crypto streams.

> Duplex streams are streams that implement both the Readable and Writable interfaces. See above for usage.

#### Emitted if there was an error when writing or piping data

***

```js
writer.on("error", function (src) {});
```

#### This is emitted whenever the unpipe() method is called on a readable stream, removing this writable from its set of destinations

***

```js
writer.on("unpipe", function (src) {});
```

#### This is emitted whenever the pipe() method is called on a readable stream, adding this writable to its set of destinations

***

***

```js
writer.on("pipe", function (src) {});
```

#### When the end() method has been called, and all data has been flushed to the underlying system, this event is emitted

***

```js
writer.on("finish", function () {});
```

#### Call this method when no more data will be written to the stream

***

***

```js
writable.end([chunk], [encoding], [callback]);
```

#### If a writable.write(chunk) call returns false, then the drain event will indicate when it is appropriate to begin writing more data to the stream

***

```js
writer.once("drain", write);
```

#### This method writes some data to the underlying system, and calls the supplied callback once the data has been fully handled

***

***

```js
let writer = getWritableStreamSomehow();
writable.write(chunk, [encoding], [callback]);
```

***

> Examples of writable streams include: http requests on the client, http responses on the server, fs write streams, zlib streams, crypto streams, tcp sockets, child process stdin, process.stdout, process.stderr.

> The Writable stream interface is an abstraction for a destination that you are writing data to.

#### This is useful in certain cases where a stream is being consumed by a parser, which needs to "un-consume" some data that it has optimistically pulled out of the source, so that the stream can be passed on to some other party

***

```js
readable.unshift(chunk);
```

#### This method will remove the hooks set up for a previous pipe() call. If the destination is not specified, then all pipes are removed

***

```js
readable.unpipe([destination]);
```

#### This method pulls all the data out of a readable stream, and writes it to the supplied destination, automatically managing the flow so that the destination is not overwhelmed by a fast readable stream

***

```js
readable.pipe(destination, [options]);
```

#### This method will cause a stream in flowing-mode to stop emitting data events

***

```js
readable.pause();
```

#### This method will cause the readable stream to resume emitting data events

***

```js
readable.resume();
```

#### Call this function to cause the stream to return strings of the specified encoding instead of Buffer objects

***

```js
readable.read([size]);
readable.setEncoding(encoding);
```

***

> This method should only be called in non-flowing mode. In flowing-mode, this method is called automatically until the internal buffer is drained.

> The read() method pulls some data out of the internal buffer and returns it. If there is no data available, then it will return null.

#### Emitted if there was an error receiving data

***

***

```js
readable.on("error", function () {});
```

#### Emitted when the underlying resource (for example, the backing file descriptor) has been closed. Not all streams will emit this

***

***

```js
readable.on("close", function () {});
```

#### This event fires when there will be no more data to read

***

```js
readable.on("end", function () {});
```

#### If you attach a data event listener, then it will switch the stream into flowing mode, and data will be passed to your handler as soon as it is available

***

***

```js
readable.on("data", function (chunk) {});
```

#### When a chunk of data can be read from the stream, it will emit a 'readable' event

***

```js
let readable = getReadableStreamSomehow();
readable.on("readable", function () {});
```

***

> Examples of readable streams include: http responses on the client, http requests on the server, fs read streams zlib streams, crypto streams, tcp sockets, child process stdout and stderr, process.stdin.

> A Readable stream will not start emitting data until you indicate that you are ready to receive it.

> In other words, data comes out of a Readable stream.

> The Readable stream interface is the abstraction for a source of data that you are reading from.

> Streams are readable, writable, or both. All streams are instances of EventEmitter.

> A stream is an abstract interface implemented by various objects in Node. For example a request to an HTTP server is a stream, as is stdout.

#### Return the number of listeners for a given event

***

***

```js
EventEmitter.listenerCount(emitter, event);
```

#### Execute each of the listeners in order with the supplied arguments. Returns true if event had listeners, false otherwise

***

***

```js

emitter.emit(event, [arg1], [arg2], [...]);
```

#### Returns an array of listeners for the specified event

***

```js
emitter.listeners(event);
```

#### By default EventEmitters will print a warning if more than 10 listeners are added for a particular event

***

```js
emitter.setMaxListeners(n);
```

#### Removes all listeners, or those of the specified event

***

```js
emitter.removeAllListeners([event]);
```

#### Remove a listener from the listener array for the specified event

***

```js
emitter.removeListener(event, listener);
```

***

> Adds a one time listener for the event. This listener is invoked only the next time the event is fired, after which it is removed.

```js
emitter.once(event, listener);
```

#### Same as emitter.addListener()

***

```js
emitter.on(event, listener);
```

#### Adds a listener to the end of the listeners array for the specified event

***

```js
emitter.addListener(event, listener);
```

***

> All EventEmitters emit the event 'newListener' when new listeners are added and 'removeListener' when a listener is removed.

#### To access the EventEmitter class, require('events').EventEmitter

***

> All objects which emit events are instances of events.EventEmitter. You can access this module by doing: require("events");

## EVENTS

***

#### Inherit the prototype methods from one constructor into another

***

***

```js
util.inherits(constructor, superConstructor);
```

#### Takes a function whose last argument is a callback and returns a version that returns promises

***

```js
util.promisify(fn);
```

#### Returns true if the given "object" is an Error. false otherwise

***

```js
util.isError(object);
```

#### Returns true if the given "object" is a Date. false otherwise

***

```js
util.isDate(object);
```

#### Returns true if the given "object" is a RegExp. false otherwise

***

```js
util.isRegExp(object);
```

***

> Returns true if the given "object" is an Array. false otherwise.

> util.isArray(object);

#### Return a string representation of object, which is useful for debugging. (options: showHidden, depth, colors, customInspect)

***

***

```js
util.inspect(object, [opts]);
```

***

> Output with timestamp on stdout.

> util.log(string);

#### A synchronous output function. Will block the process, cast each argument to a string then output to stdout. (no newlines)

***

```js

util.print([...]);
```

#### A synchronous output function. Will block the process and output all arguments to stdout with newlines after each argument

***

```js

util.puts([...]);
```

#### Same as util.debug() except this will output all arguments immediately to stderr

***

```js

util.error([...]);
```

#### A synchronous output function. Will block the process and output string immediately to stderr

***

***

> util.debug(string);

#### Returns a formatted string using the first argument as a printf-like format. (%s, %d, %j)

***

```js

util.format(format, [...]);
```

***

> These functions are in the module 'util'. Use require('util') to access them.

#### This is a special case of the spawn() functionality for spawning Node processes. In addition to having all the methods in a normal ChildProcess instance, the returned object has a communication channel built-in

***

***

```js
child_process.fork(modulePath, [args], [options]);
```

#### Runs a command in a shell and buffers the output

***

***

```js
child_process.execFile(file, [args], [options], [callback]);
```

#### Runs a command in a shell and buffers the output

***

```js
child_process.exec(command, [options], callback);
```

#### Launches a new process with the given command, with command line arguments in args. If omitted, args defaults to an empty Array

***

```js
child_process.spawn(command, [args], [options]);
```

#### Close the IPC channel between parent and child, allowing the child to exit gracefully once there are no other connections keeping it alive

***

```js
child.disconnect();
```

***

#### When using child\_process.fork() you can write to the child using child.send(message, \[sendHandle]) and messages are received by a 'message' event on the child

***

```js
> child.send(message, [sendHandle]);
```

#### Send a signal to the child process

***

```


---

###   If .connected is false, it is no longer possible to send messages
child.kill([signal]);
```

> child.connected;

#### The PID of the child process

***

```js
child.pid;
```

#### A Readable Stream that represents the child process's stderr

***

```


---

###   A Readable Stream that represents the child process's stdout
child.stderr;
```

> child.stdout;

#### A Writable Stream that represents the child process's stdin

***

```js
child.stdin;
```

#### Class. ChildProcess is an EventEmitter

***

```js
ChildProcess;
```

***

> It is possible to stream data through a child's stdin, stdout, and stderr in a fully non-blocking way.

> Node provides a tri-directional popen facility through the child\_process module.

#### Returns the current high-resolution real time in a \[seconds, nanoseconds] tuple Array

***

```js
process.hrtime();
```

#### Number of seconds Node has been running

***

```js
process.uptime();
```

#### Sets or reads the process's file mode creation mask

***

```js
process.umask([mask]);
```

#### Callbacks passed to process.nextTick will usually be called at the end of the current flow of execution, and are thus approximately as fast as calling a function synchronously

***

```js
process.maxTickDepth;
```

#### On the next loop around the event loop call this callback

***

```js
process.nextTick(callback);
```

#### Returns an object describing the memory usage of the Node process measured in bytes

***

```js
process.memoryUsage();
```

#### Send a signal to a process. pid is the process id and signal is the string describing the signal to send

***

```js
process.kill(pid, [signal]);
```

#### Reads /etc/group and initializes the group access list, using all groups of which the user is a member

***

***

```js
process.initgroups(user, extra_grp);
```

#### Sets the supplementary group IDs

***

***

```js
process.setgroups(grps);
```

#### Returns an array with the supplementary group IDs

***

***

```js
process.getgroups();
```

#### Sets the user identity of the process

***

```js
process.setuid(id);
```

#### Gets the user identity of the process

***

```js
process.getuid();
```

#### Sets the group identity of the process

***

```js
process.setgid(id);
```

#### Gets the group identity of the process

***

```js
process.getgid();
```

***

> ?process.exit(\[code]);\
> Ends the process with the specified code. If omitted, exit uses the 'success' code 0.

#### Returns the current working directory of the process

***

***

```js
process.cwd();
```

#### Changes the current working directory of the process or throws an exception if that fails

***

```js
process.chdir(dir);
```

#### This causes node to emit an abort. This will cause node to exit and generate a core file

***

```js

> process.abort();
```

#### A property exposing version strings of node and its dependencies

***

```js
process.versions;
```

***

> hat exposes NODE\_VERSION.

#### A compiled-in property t

***

```js
process.version;
```

#### Getter/setter to set what is displayed in 'ps'

***

***

```js
process.title;
```

#### What platform you're running on: 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'

***

```js
process.platform;
```

#### The PID of the process

***

```js
process.pid;
```

#### An Object containing the JavaScript representation of the configure options that were used to compile the current node executable

***

```js
process.config;
```

#### What processor architecture you're running on: 'arm', 'ia32', or 'x64'

***

```js
process.arch;
```

#### This is the set of node-specific command line options from the executable that started the process

***

```js
process.execArgv;
```

#### This is the absolute pathname of the executable that started the process

***

```js
process.execPath;
```

#### An object containing the user environment

***

```js
process.env;
```

#### An array containing the command line arguments

***

```js
process.argv;
```

#### A readable stream for stdin

***

***

```js
process.stdin;
```

#### A writable stream to stderr

***

```js
process.stderr;
```

#### A writable stream to stdout

***

```js
process.stdout;
```

> Emitted when an exception bubbles all the way back to the event loop. (should not be used)

***

```js
> process.on('uncaughtException', function(err) {});
```

#### Emitted when the process is about to exit

***

```js
process.on("exit", function (code) {});
```

***

```js
module.exports = function (width) {
  return {
    area: function () {
      return width * width;
    },
  };
};
```

***

> or if you want to export a complete object in one assignment instead of building it one property at a time, assign it to module.exports instead of exports.

#### If you want the root of your module's export to be a function (such as a constructor)

***

```js
exports.area = function (r) {
  return Math.PI * r * r;
};
```

#### The module objects required by this one

***

***

```js
module.children;
```

#### The module that required this one

***

```js
module.parent;
```

#### Whether or not the module is done loading, or is in the process of loading

***

```js
module.loaded;
```

#### The fully resolved filename to the module

***

***

```js
module.filename;
```

#### The identifier for the module. Typically this is the fully resolved filename

***

```js
module.id;
```

#### load another\_module as if require() was called from the module itself

***

***

```js
module.require("./another_module.js");
```

***

> Loads the module module.js in the same directory.

> let module = require('./module.js');

#### If you had previously unref()d a timer you can call ref() to explicitly request the timer hold the program open

***

```js
ref();
```

#### Allow you to create a timer that is active but if it is the only item left in the event loop, node won't keep the program running

***

```js
unref();
```

#### Stop a timer that was previously created with setImmediate()

***

```js
clearImmediate(immediateObject);
```

#### To schedule the "immediate" execution of callback after I/O events callbacks and before setTimeout and setInterval

***

```js

setImmediate(callback, [arg], [...]);
```

#### Stop a timer that was previously created with setInterval()

***

```js
clearInterval(t);
```

#### To schedule the repeated execution of callback every delay milliseconds. Optionally you can also pass arguments to the callback

***

***

```js

setInterval(callback, delay, [arg], [...]);
```

#### Stop a timer that was previously created with setTimeout()

***

```js
clearTimeout(t);
```

#### To schedule execution of a one-time callback after delay milliseconds. Optionally you can also pass arguments to the callback

***

```js

setTimeout(callback, delay, [arg], [...]);
```

#### Same as assert.ok() where if the expression evaluates as false throw an AssertionError with message

***

***

```js
console.assert(expression, [message]);
```

#### Print a stack trace to stderr of the current position

***

***

```js
console.trace(label);
```

#### Finish timer, record output

***

```js
console.timeEnd(label);
```

#### Mark a time

***

***

```js
console.time(label);
```

#### Uses util.inspect on obj and prints resulting string to stdout

***

```js
console.dir(obj);
```

#### Same as console.error

***

***

```js

console.warn([data], [...]);
```

#### Same as console.log but prints to stderr

***

***

```js

console.error([data], [...]);
```

***

> Same as console.log.

```js

console.info([data], [...]);
```

#### Prints to stdout with newline

***

***

```js

console.log([data], [...]);
```

#### The Buffer class is a global type for dealing with binary data directly

***

***

```js
Buffer;
```

#### The process object is a global object and can be accessed from anywhere. It is an instance of EventEmitter

***

***

```js
process;
```

#### A reference to the module.exports that is shorter to type

***

***

```js
exports;
```

#### A reference to the current module. In particular module.exports is used for defining what a module exports and makes available through require()

***

***

```


---

###   The name of the directory that the currently executing script resides in. (absolute path)
module;
```

> \_\_dirname;

#### The filename of the code being executed. (absolute path)

***

***

```js
__filename;
```

***

> In Node this is different. The top-level scope is not the global scope; let something inside a Node module will be local to that module.

> That means that in browsers if you're in the global scope let something will define a global variable.

#### In browsers, the top-level scope is the global scope

***

### GLOBAL OBJECTS

```js
http
  .createServer(function (request, response) {
    response.writeHead(200, { "Content-Type": "text/plain" });
    response.end("Hello World\n");
  })
  .listen(8124);
console.log("Server running at http://127.0.0.1:8124/");
```

***

> To run the server, put the code into a file called example.js and execute it with the node program.

#### An example of a web server written with Node which responds with 'Hello World'

***

```js
let http = require("http");
```

***

## NodeJS

***

***

***

***

***

#### Returns a new Array Iterator object that contains the values for each index in the array

***

```js
arr.values();
```

#### Returns true if at least one element in this array satisfies the provided testing function

***

```js

arr.some(callback[, initialValue]);
```

#### Apply a function against an accumulator and each value of the array (from right-to-left) as to reduce it to a single value

***

```js

arr.reduceRight(callback[, initialValue]);
```

#### Apply a function against an accumulator and each value of the array (from left-to-right) as to reduce it to a single value

***

```js

arr.reduce(callback[, initialValue]);
```

#### Creates a new array with the results of calling a provided function on every element in this array

***

```js

arr.map(callback[, initialValue]);
```

#### Returns a new Array Iterator that contains the keys for each index in the array

***

```js
arr.keys();
```

#### Calls a function for each element in the array

***

```js

arr.forEach(callback[, thisArg]);
```

#### Returns the found index in the array, if an element in the array satisfies the provided testing function or -1 if not found

***

```js

arr.findIndex(callback[, thisArg]);
```

#### Returns the found value in the array, if an element in the array satisfies the provided testing function or undefined if not found

***

```js

arr.find(callback[, thisArg]);
```

#### Creates a new array with all of the elements of this array for which the provided filtering function returns true

***

```js

arr.filter(callback[, thisArg]);
```

#### Returns true if every element in this array satisfies the provided testing function

***

```js

arr.every(callback[, thisArg]);
```

#### Returns a new Array Iterator object that contains the key/value pairs for each index in the array

***

```js
arr.entries();
```

> Instance: iteration methods

#### Returns a localized string representing the array and its elements. Overrides the Object.prototype.toLocaleString() method

***

```js
arr.toLocaleString(locales, options);
```

#### Returns a string representing the array and its elements. Overrides the Object.prototype.toString() method

***

```js
arr.toString();
```

#### Extracts a section of an array and returns a new array

***

```js
arr.slice(begin, end);
```

#### Returns the last (greatest) index of an element within the array equal to the specified value, or -1 if none is found

***

```js
arr.lastIndexOf(searchElement, fromIndex);
```

#### Joins all elements of an array into a string

***

```js
arr.join(separator);
```

#### Returns the first (least) index of an element within the array equal to the specified value, or -1 if none is found

***

```js

arr.indexOf(searchElement[, fromIndex]);
```

#### Determines whether an array contains a certain element, returning true or false as appropriate

***

```js
arr.includes(searchElement, fromIndex);
```

#### Returns a new array comprised of this array joined with other array(s) and/or value(s)

***

```js

arr.concat(value1[, value2[, ...[, valueN]]]);
```

> Instance: accessor methods

#### Adds one or more elements to the front of an array and returns the new length of the array

***

```js

arr.unshift([element1[, ...[, elementN]]]);
```

***

> Adds and/or removes elements from an array.

```js

array.splice(start, deleteCount, item1, item2, ...)
```

#### Sorts the elements of an array in place and returns the array

***

```js
arr.sort();
```

#### Removes the first element from an array and returns that element

***

```js
arr.shift();
```

#### Reverses the order of the elements of an array in place — the first becomes the last, and the last becomes the first

***

```js
arr.reverse();
```

#### Adds one or more elements to the end of an array and returns the new length of the array

***

```js

arr.push([element1[, ...[, elementN]]]);
```

#### Removes the last element from an array and returns that element

***

```js
arr.pop();
```

#### Fills all the elements of an array from a start index to an end index with a static value

***

```js
arr.fill(value, start, end);
```

#### Copies a sequence of array elements within the array

***

```js
arr.copyWithin(target, start, end);
```

> Instance: mutator methods

#### Reflects the number of elements in an array

***

```js
arr.length;
```

> Instance: properties

#### Creates a new Array instance with a variable number of arguments, regardless of number or type of the arguments

***

```js

Array.of(element0[, element1[, ...[, elementN]]]);
```

#### Returns true if a variable is an array, if not false

***

```js
Array.isArray(obj);
```

#### Creates a new Array instance from an array-like or iterable object

***

```js
Array.from(arrayLike[, mapFn[, thisArg]]);
```

### Global object: methods

#### Represents the prototype for the Array constructor and allows to add new properties and methods to all Array objects

***

```js
Array.prototype;
```

#### Reflects the number of elements in an array

***

```js
Array.length;
```

### Global object: properties

#### Returns the primitive value of the specified object

***

```js
object.valueOf();
```

#### Returns a string representation of the object

***

```js
obj.toString();
```

#### Calls toString()

***

```js
obj.toLocaleString();
```

#### Returns a boolean indicating if the internal ECMAScript \[\[Enumerable]] attribute is set

***

```js
obj.propertyIsEnumerable(prop);
```

#### Returns a boolean indicating whether the object this method is called upon is in the prototype chain of the specified object

***

```js
prototypeObj.isPrototypeOf(object);
```

#### Returns a boolean indicating whether an object contains the specified property as a direct property of that object and not inherited through the prototype chain

***

```js
obj.hasOwnProperty(prop);
```

> Methods

#### Points to the object which was used as prototype when the object was instantiated

***

```js
obj.__proto__;
```

#### Specifies the function that creates an object's prototype

***

```js
obj.constructor;
```

> Object instances and Object prototype object (Object.prototype.property or Object.prototype.method()) Properties

#### Returns an array containing the values that correspond to all of a given object's own enumerable string properties

***

```js
Object.values(obj);
```

#### Sets the prototype (i.e., the internal \[\[Prototype]] property)

***

```js
Object.setPrototypeOf(obj, prototype);
```

#### Prevents other code from deleting properties of an object

***

```js
Object.seal(obj);
```

#### Prevents any extensions of an object

***

```js
Object.preventExtensions(obj);
```

#### Returns an array containing the names of all of the given object's own enumerable string properties

***

```js
Object.keys(obj);
```

#### Determines if an object is sealed

***

```js
Object.isSealed(obj);
```

#### Determines if an object was frozen

***

```js
Object.isFrozen(obj);
```

#### Determines if extending of an object is allowed

***

```js
Object.isExtensible(obj);
```

#### Compares if two values are the same value. Equates all NaN values (which differs from both Abstract Equality Comparison and Strict Equality Comparison)

***

```js
Object.is(value1, value2);
```

#### Returns the prototype of the specified object

***

```js
Object.getPrototypeOf(obj);
```

#### Returns an array of all symbol properties found directly upon a given object

***

```js
Object.getOwnPropertySymbols(obj);
```

#### Returns an array containing the names of all of the given object's own enumerable and non-enumerable properties

***

```js
Object.getOwnPropertyNames(obj);
```

#### Returns an object containing all own property descriptors for an object

***

```js
Object.getOwnPropertyDescriptors(obj);
```

#### Returns a property descriptor for a named property on an object

***

```js
Object.getOwnPropertyDescriptor(obj, prop);
```

#### Freezes an object: other code can't delete or change any properties

***

```js
Object.freeze(obj);
```

#### Returns an array containing all of the \[key, value] pairs of a given object's own enumerable string properties

***

```js
Object.entries(obj);
```

#### Adds the named properties described by the given descriptors to an object

***

```js
Object.defineProperties(obj, props);
```

#### Adds the named property described by a given descriptor to an object

***

```js
Object.defineProperty(obj, prop, descriptor);
```

#### Creates a new object with the specified prototype object and properties. The object which should be the prototype of the newly-created object

***

```js
Object.create(MyObject);
```

#### Copies the values of all enumerable own properties from one or more source objects to a target object. method is used to copy the values of all enumerable own properties from one or more source objects to a target object. It will return the target object

***

```js
Object.assign(target, ...sources);
```

> Methods of the Object constructor

#### Represents the Object prototype object and allows to add new properties and methods to all objects of type Object

***

```js
Object.prototype;
```

#### length is a property of a function object, and indicates how many arguments the function expects, i.e. the number of formal parameters. This number does not include the rest parameter. Has a value of 1

***

```js
Object.length(obj);
```

> Global object: properties

## Vanilla JS

\


## JavaScript

To run a node environment:

```
docker run -it node node
>
```

### Strings and Variables

Set a variable `test`:

```
> var test = 'ok';
> console.log(test);
ok
```

With `var` you can overwrite the value:

```
> var test = 'ok';
> var test = 'ok2';
> console.log(test);
ok2
```

With `const` you cannot as the value remains what it was set initially to:

```
> const test = 'ok';
> const test = 'ok';
Uncaught SyntaxError: Identifier 'test' has already been declared
```

String interpolation:

```
> const name = 'ruan';
> var msg = `my name is ${name}`
> console.log(msg);
my name is ruan
```

With new line characters:

```
> var msg = `my name is:\n- ${name}`
> console.log(msg);
my name is:
- ruan
```

### IF Statements

If, else and else if:

```
> var x = 2;
> if (x == 0) {
  console.log('x is 0');
  } else if (x > 1) {
  console.log('x is more than 1');
  } else {
  console.log('x is probably 1');
}
x is more than 1
```

If statement using multiple conditions:

```
> var event = {'name': 'ruan', 'surname': 'bekker', 'age': 34, 'severity': 'Low', 'skip': false}
> if ((!event.skip && event.name == 'ruan')) {
  console.log('true');
}
true
```

The same as above, but adding OR:

```
> var event = {'name': 'ruan', 'surname': 'bekker', 'age': 34, 'severity': 'Low', 'skip': false}
> if ((!event.skip && event.name == 'frank') || (!event.skip && event.age == 34)) {
  console.log('true');
}
true
```

Or it can be written like this:

```
> var event = {'name': 'ruan', 'surname': 'bekker', 'age': 34, 'severity': 'Low', 'skip': false}
> if (!event.skip && (event.name == 'frank') || (event.age == 34)) {
  console.log('true');
}
true
```
