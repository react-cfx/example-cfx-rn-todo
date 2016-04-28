{ mergeActionsTypes } = require 'cfx.redux-types'
Visibility = require './Visibility'
Todos = require './Todos'

module.exports = mergeActionsTypes {
  Visibility
  Todos
}
