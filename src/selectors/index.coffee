{ createSelector } = require 'reselect'
constants = require '../constants/Visibility'
Types = constants.types
{
  SHOW_TODO_ALL
  SHOW_TODO_ACTIVE
  SHOW_TODO_COMPLETED
} = Types

getVisibilityFilter = (state, props) ->

  state.visibilityFilter

getTodos = (state, props) ->

  state.todos

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
      when SHOW_TODO_COMPLETED
      then todos.filter (todo) -> todo.completed
      when SHOW_TODO_ACTIVE
      then todos.filter (todo) -> !todo.completed
      when SHOW_TODO_ALL
      then todos
      else todos
)

module.exports = {
  getVisibleTodos
}
