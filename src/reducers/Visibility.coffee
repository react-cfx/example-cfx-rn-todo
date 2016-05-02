{ reduxActions } = require 'cfx.redux-actions'
{
  handleAction
} = reduxActions

constants = require '../constants/Visibility'
{
  SET_VISIBILITY_FILTER
  SET_VISIBILITY_TODO_REMOVE
  SET_VISIBILITY_ADD_MODAL
} = constants.types

VisibilityFilter = handleAction(
  SET_VISIBILITY_FILTER
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

VisibilityTodoRemove = handleAction(
  SET_VISIBILITY_TODO_REMOVE
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

VisibilityAddModal = handleAction(
  SET_VISIBILITY_ADD_MODAL
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

module.exports = {
  VisibilityFilter
  VisibilityTodoRemove
  VisibilityAddModal
}
