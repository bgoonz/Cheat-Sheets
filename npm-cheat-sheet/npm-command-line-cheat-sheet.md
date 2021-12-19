# NPM Command Line Cheat Sheet

```javascript
// 2. NPM API Documentation.
// Prior to using NPM's commands, `npm.load()` must be called.


npm.load(configs, callback);                        // load config settings

npm.commands.bin(args, callback);                   // display npm bin folder
npm.commands.bugs(package, callback);               // bugs for a package in a web browser maybe

npm.commands.cache([args], callback);                           // manage the npm cache programatically
npm.commands.cache.clean([args], callback);                     // helper
npm.commands.cache.add([args], callback);                       // helper
npm.commands.cache.read(name, version, forceBypass, callback);  // helper

npm.commands[<command>](args, callback);            // npm commands

npm.commands.config(args, callback);                // manage the npm configuration files
npm.config.get(key);                                // get a config key
npm.config.set(key, value);                         // set a config key

npm.commands.deprecate(args, callback);             // deprecate a version of a package
npm.commands.docs(package, callback);               // docs for a package in a web browser maybe
npm.commands.edit(package, callback);               // edit an installed package
npm.commands.explore(args, callback);               // browse an installed package
npm.commands.helpSearch(args, [silent,] callback);  // search the help pages
npm.commands.init(args, callback);                  // interactively create a package.json file
npm.commands.install([where,] packages, callback);  // install a package programatically
npm.commands.link([packages,] callback);            // symlink a package folder
npm.commands.ls(args, [silent,] callback);          // list installed packages
npm.commands.outdated([packages,] callback);        // check for outdated packages
npm.commands.owner(args, callback);                 // manage package owners
npm.commands.pack([packages,] callback);            // create a tarball from a package
npm.commands.prefix(args, callback);                // display prefix
npm.commands.prune([packages,] callback);           // remove extraneous packages
npm.commands.publish([packages,] callback);         // publish a package
npm.commands.rebuild([packages,] callback);         // rebuild a package
npm.commands.repo(package, callback);               // open package repository page in the browser
npm.commands.restart(packages, callback);           // start a package
npm.commands.root(args, callback);                  // display npm root
npm.commands.run-script(args, callback);            // run arbitrary package scripts

npm.commands.search(searchTerms, [silent,] [staleness,] callback);  // search for packages

npm.commands.shrinkwrap(args, [silent,] callback);  // programmatically generate package shrinkwrap file
npm.commands.start(packages, callback);             // start a package
npm.commands.stop(packages, callback);              // stop a package
npm.commands.submodule(packages, callback);         // add a package as a git submodule
npm.commands.tag(package@version, tag, callback);   // tag a published version
npm.commands.test(packages, callback);              // test a package
npm.commands.uninstall(packages, callback);         // uninstall a package programmatically
npm.commands.unpublish(package, callback);          // remove a package from the registry
npm.commands.update(packages, callback);            // update a package
npm.commands.version(newversion, callback);         // bump a package version
npm.commands.view(args, [silent,] callback);        // view registry info
npm.commands.whoami(args, callback);                // display npm username
```
