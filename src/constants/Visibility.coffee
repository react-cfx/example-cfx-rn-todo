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

  VisibilityTodoRemove: toActionsTypes {
    'SET_VISIBILITY_TODO_REMOVE'
  }
  VisibilityTodoRemoveTypes:
    types: {
      'SHOW_TODO_LIST'
      'SHOW_TODO_REMOVE'
    }

  VisibilityAddModal: toActionsTypes {
    'SET_VISIBILITY_ADD_MODAL'
  }
  VisibilityAddModalTypes:
    types: {
      'ADD_MODAL_OPENED'
      'ADD_MODAL_CLOSED'
    }
