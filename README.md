Dominatrix
==========

[![Build Status](https://travis-ci.org/robotlolita/dominatrix.png)](https://travis-ci.org/robotlolita/dominatrix)
[![Dependencies Status](https://david-dm.org/robotlolita/dominatrix.png)](https://david-dm.org/robotlolita/dominatrix.png)
[![NPM version](https://badge.fury.io/js/dominatrix.png)](http://badge.fury.io/js/dominatrix)
[![stable](http://hughsk.github.io/stability-badges/dist/stable.svg)](http://github.com/hughsk/stability-badges)


Dominatrix is a smart HTML templating library for Browsers. 

In other words, Dominatrix *cares* about the structure of your HTML, and will
allow you to safely compose even arbitrary pieces of HTML without you having to
worry about escaping your data or XSS injections!


## Philosophy

  - **Simple**: Dominatrix should provide only a couple of primitives so
    you don't need to spend hours learning a huge API and their edge cases.

  - **Safe**: You'll likely forget to escape a piece of data someday,
    Dominatrix should make it impossible for this to be a problem.
    
  - **Readable**: Templates written using Dominatrix should be readable,
    otherwise what's the point?

  - **Composable**: Composition is how you make big things in a sane way, thus
    Dominatrix should allow arbitrary pieces of template to be composed to make
    bigger things **in a safe way**.
    
  - **Work with older Browsers**: Some people still need to support old IEs,
    Dominatrix should work on them.


## Example

```js
var _ = require('dominatrix')

function link(a) { return _('a.link', { href: a.url }, a.text) }

var items = [
  { url: '/example/a', text: 'Something' }
, { url: '/example/b', text: 'More stuff' }
]

_('html'
 , _('head'
    , _('title', 'Mistress.')
    , _('meta', { charset: 'utf-8' }))
 , _('body'
    , _('div#content.item-list.simple-list', items.map(link))))
```

This generates the following HTML structure:

```html
<html>
  <head>
    <title>Mistress.</title>
    <meta charset="utf-8">
  </head>
  <body>
    <div id="content" class="item-list simple-list">
      <a class="link" href="/example/a">Something</a>
      <a class="link" href="/example/b">More stuff</a>
    </div>
  </body>
</html>
```


## Installing

The easiest way is to grab it from NPM. If you're running in a Browser
environment, you can use [Browserify][]

    $ npm install dominatrix


### Using with CommonJS

If you're not using NPM, [Download the latest release][release], and require
the `dominatrix.umd.js` file:

```js
var _ = require('dominatrix')
```


### Using with AMD

[Download the latest release][release], and require the `dominatrix.umd.js`
file:

```js
require(['dominatrix'], function(_) {
  ( ... )
})
```


### Using without modules

[Download the latest release][release], and load the `dominatrix.umd.js`
file. The properties are exposed in the global `Dominatrix` object:

```html
<script src="/path/to/dominatrix.umd.js"></script>
```


### Compiling from source

If you want to compile this library from the source, you'll need [Git][],
[Make][], [Node.js][], and run the following commands:

    $ git clone git://github.com/robotlolita/dominatrix.git
    $ cd dominatrix
    $ npm install
    $ make bundle
    
This will generate the `dist/dominatrix.umd.js` file, which you can load in
any JavaScript environment.

[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/


## Documentation

You can either [check the documentation on-line][docs], or build them
locally. To build the documentation you'll need to install [Node.js][]:

    $ npm install
    $ make documentation
    
This will generate the documentation as a series of HTML files on
`docs/build`.

[docs]: http://robotlolita.github.io/dominatrix


## Tests

You can run all tests using Mocha (you'll also need [PhantomJS][]):

    $ make test
    
You can run tests on a browser by just running `npm run pretest` and loading
`test/browser/tests.html` in a browser.

[PhantomJS]: http://phantomjs.org/


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[es5-shim]: https://github.com/kriskowal/es5-shim

[![browser support](http://ci.testling.com/robotlolita/dominatrix.png)](http://ci.testling.com/robotlolita/dominatrix)


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/robotlolita/dominatrix/blob/master/LICENCE).

<!-- [release: https://github.com/robotlolita/dominatrix/releases/download/v$VERSION/dominatrix-$VERSION.tar.gz] -->
[release]: https://github.com/robotlolita/dominatrix/releases/download/v0.0.0/dominatrix-0.0.0.tar.gz
<!-- [/release] -->
