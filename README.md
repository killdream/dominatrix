Dominatrix
==========

[![Build Status](https://travis-ci.org/killdream/dominatrix.png)](https://travis-ci.org/killdream/dominatrix)
[![Dependencies Status](https://david-dm.org/killdream/dominatrix.png)](https://david-dm.org/killdream/dominatrix.png)
[![NPM version](https://badge.fury.io/js/dominatrix.png)](http://badge.fury.io/js/dominatrix)
[![stable](http://hughsk.github.io/stability-badges/dist/stable.svg)](http://github.com/hughsk/stability-badges)


[![browser support](http://ci.testling.com/killdream/dominatrix.png)](http://ci.testling.com/killdream/dominatrix)


Dominatrix is a smart HTML templating library for Browsers. In other words,
Dominatrix *cares* about the structure of your HTML, and will allow you to
safely compose even arbitrary pieces of HTML without you having to worry about
escaping your data or XSS injections!


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
  { url: '/example/a', 'Something' }
, { url: '/example/b', 'More stuff' }
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

The easiest way is to grab it from NPM (if you're in the Browser, use [Browserify][]):

    $ npm install dominatrix
    
If you don't want to use NPM and/or Browserify, you'll need to compile the
library yourself. You'll need [Git][], [Make][] and [Node.js][]:

    $ git clone git://github.com/killdream/dominatrix.git
    $ cd dominatrix
    $ npm install
    $ make bundle
    
And use the `dist/dominatrix.umd.js` file without a module system, or with an
AMD module system like Require.js.
    
[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/


## Documentation

You can either [check the documentation on-line][docs], or build them
locally. To build the documentation you'll need to install [type.writer][], and [Node.js][]:

    $ npm install
    $ make documentation
    
This will generate the documentation as a series of HTML files on
`docs/build`.


## Tests

You can run all tests using Mocha (you'll also need [PhantomJS][]):

    $ make test
    
You can run tests on a browser by just running `npm run pretest` and loading
`test/browser/tests.html` in a browser.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[es5-shim]: https://github.com/kriskowal/es5-shim


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/killdream/dominatrix/blob/master/LICENCE).


