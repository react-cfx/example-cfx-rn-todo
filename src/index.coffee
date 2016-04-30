{ Comp } = require 'cfx.rn'

# For fix cuid()
unless navigator.mimeTypes
  navigator.mimeTypes = []

App = require './App/index'

Comp.reg 'ExampleCfxRnTodo'
, -> App
