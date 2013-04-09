## Module dominatrix
#
# Push brand new DOM structures into pleasant submission!
#
# 
# Copyright (c) 2013 Quildreen "Sorella" Motta <quildreen@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### -- Interfaces ------------------------------------------------------

#### type Selector
# A CSS-like selector string that includes only classes and IDs.
#
# :: String

#### type SelectorD
# A structural representation of a Selector.
# 
# :: { "id"      :: String
# .. , "tag"     :: String
# .. , "classes" :: [String]
# .. }

#### type SelectorKind
# The type of a Selector component.
#
# :: id | tag | class

#### type Node-like
# Something that we can lift into a Node.
#
# :: String | Node


### -- Aliases ---------------------------------------------------------
keys = Object.keys


### -- Helpers ---------------------------------------------------------

#### λ is-object
# Checks if something is an object.
#
# :: a -> Bool
is-object = (a) -> (Object a) is a


#### λ is-node
# Checks if something is an DOM Node.
#
# :: a -> Bool
is-node = (a) -> a?.node-type?


#### λ kind
# Returns the type of a Selector component.
#
# :: String -> SelectorKind
kind = (component) -> switch component.char-at 0
  | '#' => 'id'
  | '.' => 'class'
  |  _  => 'tag'


#### λ parse-selector
# Constructs a SelectorD structure from a Selector text.
#
# :: Selector -> SelectorD
parse-selector = (text) ->
  components = text.split /(?=#|\.)/
  selector   = { classes: [], id: '', tag: '' }

  for component in components
    switch (kind component)
    | 'class' => selector.classes.push (component.slice 1)
    | 'id'    => selector.id  = (component.slice 1)
    | _       => selector.tag = component

  return selector


#### λ set-properties
# Defines all properties in an Object in the HTMLElement.
#
# :: HTMLElement, Object -> HTMLElement
set-properties = (element, properties) ->
  names = keys properties
  for name in names => element.set-attribute name, properties[name]
  return element


#### λ append-child
# Appends several Node-like elements to an HTMLElement.
#
# :: HTMLElement, [Node-like] -> HTMLElement
append-children = (element, children) ->
  for child in children
    switch
    | array-p child  => append-children element, child
    | child !~= null => element.append-child (make-node child)

  return element


#### λ make-node
# Lifts a Node-like into an actual Node.
#
# :: Node-like -> Node
make-node = (a) ->
  | node-p a  => a
  | otherwise => document.create-text-node a


### -- Core implementation ---------------------------------------------

#### λ make-element
# :internal:
# Creates a new DOM element with the given properties.
#
# :: Selector, Object, [Node-like] -> HTMLElement
make-element = (selector, properties, children) ->
  selector = parse-selector selector
  element  = document.create-element (selector.tag or 'div')

  if selector.id      => element.set-attribute 'id' selector.id
  if selector.classes => element.set-attribute 'class' selector.classes.join ' '

  set-properties element, (properties or {})
  append-children element, (children or [])

  return element


#### λ builder
# Creates a new DOM element with the given properties.
#
# :: Selector, Object, Node-like... -> HTMLElement
# :: Selector, Node-like... -> HTMLElement
builder = (selector, ...children) ->
  if is-object children.0 => properties = children.shift!
  make-element selector, properties, children



### -- Exports ---------------------------------------------------------
module.exports = builder
