echo = -> console.log arguments

{
  cfx
  Provider
} = require 'cfx.rn'

{ createStore } = require 'cfx.redux'

reducers = require '../reducers/Visibility'

createLogger = require 'redux-logger'

store = createStore
  todoApp: reducers
, [
  createLogger()
]

TodoApp = require './TodoApp'

module.exports = cfx ->

  Provider { store }
  ,
    TodoApp()
