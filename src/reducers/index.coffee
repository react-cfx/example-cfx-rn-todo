{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index'
{
  VisibilityFilter
  VisibilitySettings
  VisibilityContainer
  VisibilityAllToRemove
} = require './Visibility'
{
  Todos
} = require './Todos'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilitySettings
  VisibilityContainer
  VisibilityAllToRemove
  Todos
}
, initialState
