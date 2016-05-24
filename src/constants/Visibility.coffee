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

  VisibilitySettings: toActionsTypes {
    'SET_VISIBILITY_SETTINGS'
  }
  VisibilitySettingsTypes:
    types: {
      'SETTINGS_OPENED'
      'SETTINGS_CLOSEED'
    }

  VisibilityContainer: toActionsTypes {
    'SET_VISIBILITY_CONTAINER'
  }
  VisibilityContainerTypes:
    types: {
      'SHOW_TODO_LIST'
      'SHOW_TODO_REMOVE'
      'SHOW_TODO_INFO'
    }

  VisibilityAllToRemove: toActionsTypes {
    'SET_VISIBILITY_ALL_TO_REMOVE'
  }
  VisibilityAllToRemoveTypes:
    types: {
      'SELECT_ALL_TO_REMOVE'
      'CANCEL_ALL_TO_REMOVE'
    }
