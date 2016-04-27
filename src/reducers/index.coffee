{ mergeReduce } = require 'cfx.redux'
{ initialState } = require '../initials/index'
{
  VisibilityFilter
  VisibilityAddModal
} = require './Visibility'
{
  Todos
} = require './Todos'

module.exports = mergeReduce {
  VisibilityFilter
  VisibilityAddModal
  Todos
}
, initialState
