constants = require '../constants/Visibility'
{
  SHOW_TODO_ALL
  ADD_MODAL_CLOSED
} = constants.types

module.exports = do ->

  initial =
    VisibilityFilter: SHOW_TODO_ALL
    VisibilityAddModal: ADD_MODAL_CLOSED

  {
    initial
    initialState: initial
  }
