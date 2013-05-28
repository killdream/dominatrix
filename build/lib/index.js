(function(){
  var keys, isArray, isObject, isNode, kind, parseSelector, setProperties, appendChildren, makeNode, makeElement, builder, slice$ = [].slice;
  keys = Object.keys;
  isArray = Array.isArray;
  isObject = function(a){
    return !isArray(a) && !isNode(a) && Object(a) === a;
  };
  isNode = function(a){
    return (a != null ? a.nodeType : void 8) != null;
  };
  kind = function(component){
    switch (component.charAt(0)) {
    case '#':
      return 'id';
    case '.':
      return 'class';
    default:
      return 'tag';
    }
  };
  parseSelector = function(text){
    var components, selector, i$, len$, component;
    components = text.split(/(?=#|\.)/);
    selector = {
      classes: [],
      id: '',
      tag: ''
    };
    for (i$ = 0, len$ = components.length; i$ < len$; ++i$) {
      component = components[i$];
      switch (kind(component)) {
      case 'class':
        selector.classes.push(component.slice(1));
        break;
      case 'id':
        selector.id = component.slice(1);
        break;
      default:
        selector.tag = component;
      }
    }
    return selector;
  };
  setProperties = function(element, properties){
    var names, i$, len$, name;
    names = keys(properties);
    for (i$ = 0, len$ = names.length; i$ < len$; ++i$) {
      name = names[i$];
      element.setAttribute(name, properties[name]);
    }
    return element;
  };
  appendChildren = function(element, children){
    var i$, len$, child;
    for (i$ = 0, len$ = children.length; i$ < len$; ++i$) {
      child = children[i$];
      switch (false) {
      case !isArray(child):
        appendChildren(element, child);
        break;
      case child == null:
        element.appendChild(makeNode(child));
      }
    }
    return element;
  };
  makeNode = function(a){
    switch (false) {
    case !isNode(a):
      return a;
    default:
      return document.createTextNode(a);
    }
  };
  makeElement = function(selector, properties, children){
    var element;
    selector = parseSelector(selector);
    element = document.createElement(selector.tag || 'div');
    if (selector.id) {
      element.setAttribute('id', selector.id);
    }
    if (selector.classes) {
      element.setAttribute('class', selector.classes.join(' '));
    }
    setProperties(element, properties || {});
    appendChildren(element, children || []);
    return element;
  };
  builder = function(selector){
    var children, properties;
    children = slice$.call(arguments, 1);
    if (isObject(children[0])) {
      properties = children.shift();
    }
    return makeElement(selector, properties, children);
  };
  module.exports = builder;
}).call(this);
