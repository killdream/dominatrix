Dominatrix
==========

[![Build Status](https://travis-ci.org/killdream/dominatrix.png)](https://travis-ci.org/killdream/dominatrix)
![Dependencies Status](https://david-dm.org/killdream/dominatrix.png)

[![browser support](http://ci.testling.com/killdream/dominatrix.png)](http://ci.testling.com/killdream/dominatrix)


Push brand new DOM structures into pleasant submission!


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

Just grab it from NPM:

    $ npm install dominatrix


## Documentation

A quick reference of the API can be built using [Calliope][]:

    $ npm install -g calliope
    $ calliope build


## Tests

You can run all tests using Mocha (you'll also need PhantomJS):

    $ npm test
    
You can run tests on a browser by just running `npm run pretest` and loading
`test/browser/tests.html` in a browser.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3


## Licence

MIT/X11. ie.: do whatever you want.

[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
