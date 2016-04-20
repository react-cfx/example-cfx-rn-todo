echo = -> console.log arguments

{
  cfx
  Provider
} = require 'cfx.rn'

{ createStore } = require 'cfx.redux'
{ createSagaMiddleware } = require 'cfx.redux-saga'

{
  reducers
  sagas
} = require 'cfx.example-cfx-redux-counter'

createLogger = require 'redux-logger'

store = createStore
  countApp: reducers
, [
  createLogger()
  createSagaMiddleware sagas
]

CounterApp = require './CounterApp'

module.exports = cfx ->

  Provider { store }
  ,
    CounterApp()
