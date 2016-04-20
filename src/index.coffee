{ Comp } = require 'cfx.rn'

App = require './App/TodoApp'
# App = require './components/TitleBar'
# App = require './components/TodoList'
# App = require './components/Filters'

Comp.reg 'ExampleCfxRnTodo'
, -> App
