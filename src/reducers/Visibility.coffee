{ reduxActions } = require 'cfx.redux-actions'
{
  handleAction
} = reduxActions

constants = require '../constants/Visibility'
{
  SET_VISIBILITY_FILTER
  SET_VISIBILITY_CONTAINER
  SET_VISIBILITY_ALL_TO_REMOVE
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

VisibilityContainer = handleAction(
  SET_VISIBILITY_CONTAINER
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

VisibilityAllToRemove = handleAction(
  SET_VISIBILITY_ALL_TO_REMOVE
  next: (state, action) -> action.payload
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

module.exports = {
  VisibilityFilter
  VisibilityContainer
  VisibilityAllToRemove
}
