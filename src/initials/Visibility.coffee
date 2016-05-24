constants = require '../constants/Visibility'
{
  SHOW_TODO_ACTIVE
  SETTINGS_CLOSEED
  SHOW_TODO_LIST
  CANCEL_ALL_TO_REMOVE
} = constants.types

initial =
  VisibilityFilter: SHOW_TODO_ACTIVE
  VisibilitySettings: SETTINGS_CLOSEED
  VisibilityContainer: SHOW_TODO_LIST
  VisibilityAllToRemove: CANCEL_ALL_TO_REMOVE

module.exports = {
  initial
  initialState: initial
}
