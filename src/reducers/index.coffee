{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index'
{
  VisibilityFilter
  VisibilityTodoRemove
  VisibilityAllToRemove
  VisibilityAddModal
} = require './Visibility'
{
  Todos
} = require './Todos'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilityTodoRemove
  VisibilityAllToRemove
  VisibilityAddModal
  Todos
}
, initialState
