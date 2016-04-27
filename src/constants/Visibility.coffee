{
  toActionsTypes
  mergeActionsTypes
} = require 'cfx.redux-types'

module.exports = mergeActionsTypes

  VisibilityFilter: toActionsTypes {
    'SET_VISIBILITY_FILTER'
  }
  VisibilityFilterTypes:
    types: {
      'SHOW_TODO_ALL'
      'SHOW_TODO_ACTIVE'
      'SHOW_TODO_COMPLETED'
    }

  VisibilityAddModal: toActionsTypes {
    'SET_VISIBILITY_ADD_MODAL'
  }
  VisibilityAddModalTypes:
    types: {
      'ADD_MODAL_OPENED'
      'ADD_MODAL_CLOSED'
    }
