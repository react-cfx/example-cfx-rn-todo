constants = require '../constants/Visibility'
{
  SHOW_TODO_ACTIVE
  SHOW_TODO_LIST
  CANCEL_ALL_TO_REMOVE
} = constants.types

initial =
  VisibilityFilter: SHOW_TODO_ACTIVE
  VisibilityContainer: SHOW_TODO_LIST
  VisibilityAllToRemove: CANCEL_ALL_TO_REMOVE

module.exports = {
  initial
  initialState: initial
}
