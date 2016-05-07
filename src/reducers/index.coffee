{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index'
{
  VisibilityFilter
  VisibilityContainer
  VisibilityAllToRemove
} = require './Visibility'
{
  Todos
} = require './Todos'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilityContainer
  VisibilityAllToRemove
  Todos
}
, initialState
