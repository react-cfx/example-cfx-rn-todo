{ createSelector } = require 'reselect'
constants = require '../constants/Visibility'
Types = constants.types
{
  SHOW_TODO_ALL
  SHOW_TODO_COMPLETED
  SHOW_TODO_ACTIVE
} = Types

getVisibilityFilter = (state, props) ->

  state.todoApp.visibilityFilter

getTodos = (state, props) ->

  state.todoApp.todos

getVisibleTodos = createSelector(
  [
    getVisibilityFilter
    getTodos
  ]
  (
    visibilityFilter
    todos
  ) ->
    switch visibilityFilter
      when 'SHOW_COMPLETED'
      then todos.filter (todo) -> todo.completed
      when 'SHOW_ACTIVE'
      then todos.filter (todo) -> !todo.completed
      else todos
)

module.exports = getVisibleTodos
