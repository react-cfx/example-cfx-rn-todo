{ reduxActions } = require 'cfx.redux-actions'
{
  handleAction
} = reduxActions
{ mergeReduce } = require 'cfx.redux'
constants = require '../constants/Visibility'
{
  SET_VISIBILITY_FILTER
  SET_VISIBILITY_ADD_MODAL
} = constants.types
{ initialState } = require '../initials/Visibility'

VisibilityFilter = handleAction(
  SET_VISIBILITY_FILTER
  next: (state, action) ->
    { filter } = action.payload
    filter
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

VisibilityAddModal = handleAction(
  SET_VISIBILITY_ADD_MODAL
  next: (state, action) ->
    { addMoal } = action.payload
    addMoal
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

module.exports = mergeReduce {
  VisibilityFilter
  VisibilityAddModal
}
, initialState
