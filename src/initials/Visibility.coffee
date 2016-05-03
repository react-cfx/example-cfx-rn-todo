constants = require '../constants/Visibility'
{
  SHOW_TODO_ACTIVE
  SHOW_TODO_LIST
  ADD_MODAL_CLOSED
} = constants.types

initial =
  VisibilityFilter: SHOW_TODO_ACTIVE
  VisibilityTodoRemove: SHOW_TODO_LIST
  VisibilityAddModal: ADD_MODAL_CLOSED

module.exports = {
  initial
  initialState: initial
}
