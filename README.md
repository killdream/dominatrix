# dominatrix [![Build Status](https://travis-ci.org/killdream/Dominatrix.png)](https://travis-ci.org/killdream/Dominatrix)  ![Dependencies Status](https://david-dm.org/killdream/Dominatrix.png)

Push brand new DOM structures into pleasant submission!


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :3

[![browser support](http://ci.testling.com/killdream/Dominatrix.png)](http://ci.testling.com/killdream/Dominatrix)


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

    $ npm install Dominatrix


## Documentation

A quick reference of the API can be built using [Calliope][]:

    $ npm install -g calliope
    $ calliope build


## Tests

You can run all tests using Mocha:

    $ npm test


## Licence

MIT/X11. ie.: do whatever you want.

[Calliope]: https://github.com/killdream/calliope
[es5-shim]: https://github.com/kriskowal/es5-shim
