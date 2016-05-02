{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index'
{
  VisibilityFilter
  VisibilityTodoRemove
  VisibilityAddModal
} = require './Visibility'
{
  Todos
} = require './Todos'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilityTodoRemove
  VisibilityAddModal
  Todos
}
, initialState
