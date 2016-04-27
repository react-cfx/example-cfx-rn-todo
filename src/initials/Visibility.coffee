constants = require '../constants/Visibility'
{
  SHOW_TODO_ALL
  ADD_MODAL_CLOSED
} = constants.types

initial =
  VisibilityFilter: SHOW_TODO_ALL
  VisibilityAddModal: ADD_MODAL_CLOSED

module.exports = {
  initial
  initialState: initial
}
