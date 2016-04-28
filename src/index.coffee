{ Comp } = require 'cfx.rn'

navigator.mimeTypes = [] unless navigator.mimeTypes

App = require './App/index'

Comp.reg 'ExampleCfxRnTodo'
, -> App
