require('es5-shim')

var assert = require('assert')
var _      = require('../../lib')


describe('λ builder()', function() {
  describe('For Selectors.', function() {
    it('Given a tag, should return an element for that tag.', function() {
      var e = _('div')
      assert.equal('DIV', e.tagName.toUpperCase())
    })

    it('Given no tag, should assume DIV.', function() {
      var e = _('')
      assert.equal('DIV', e.tagName.toUpperCase())
    })

    it('Given one or more classes, should add those.', function() {
      var e = _('.foo.bar')
      assert.deepEqual(['foo', 'bar'], e.className.split(/\s+/))
    })

    it('Given an ID, should assign that ID.', function() {
      var e = _('#foo')
      assert.equal('foo', e.id)
    })

    it('Given more than one ID, should assume the last.', function() {
      var e = _('#foo#bar')
      assert.equal('bar', e.id)
    })
  })

  describe('For attributes.', function() {
    it('Given an attribute object, should set those attributes.', function() {
      var e = _('div', { 'data-a': 1, 'title': 'foo' })
      assert.equal(1, e.getAttribute('data-a'))
      assert.equal('foo', e.getAttribute('title'))
    })
  })

  describe('For children.', function() {
    it('Given a Nothing, should do nothing.', function() {
      var e = _('div', undefined, null)
      assert.strictEqual(0, e.childNodes.length)
    })

    it('Given a Node, should append that node to the element.', function() {
      var e = _('div'), f = _('div', e)
      assert.strictEqual(e, f.childNodes[0])
    })

    it('Given a String, should create a text node.', function() {
      var e = _('div', 'foo')
      assert.strictEqual('foo', e.childNodes[0].data)
    })

    it('Given an Array, should append all the nodes.', function() {
      var a = _('div'), e = _('div', ['foo', undefined, a])
      assert.strictEqual(2, e.childNodes.length)
      assert.strictEqual('foo', e.childNodes[0].data)
      assert.strictEqual(a, e.childNodes[1])
    })
  })
})