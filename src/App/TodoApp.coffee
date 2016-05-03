echo = -> console.log arguments
{
  RN
  cfx
  cfxify
  Styl
  Comps
  connect
} = require 'cfx.rn'
{
  View
} = Comps

TitleBar = require '../components/TitleBar'
TodoList = require '../components/TodoList'
TodoRemove = require '../components/TodoRemove'
Filters = require '../components/Filters'

constants = require '../constants/index'
{
  SHOW_TODO_LIST
  SHOW_TODO_REMOVE
} = constants.types

styles = Styl

  container:
    flex: 1
    justifyContent: 'center'
  title:
    flex: 1
  list:
    flex: 1
  filters:
    flex: 1
  add:
    flex: 1

TodoApp = cfx

  _Container: (visibilityTodoRemove) ->
    switch visibilityTodoRemove
      when SHOW_TODO_LIST
      then TodoList
      when SHOW_TODO_REMOVE
      then TodoRemove
      else return # TODO throw

  constructor: (props, state) ->
    @state =
      visibilityTodoRemove: state
      Container: @_Container state
    @

  componentWillReceiveProps: (nextProps) ->

    unless @state.visibilityTodoRemove is nextProps.state
      @setState
        visibilityTodoRemove: nextProps.state
        Container: @_Container nextProps.state

  render: (props, state) ->

    View style: styles.container
    ,
      TitleBar style: styles.title
    ,
      @state.Container style: styles.list
    ,
      Filters style: styles.filters

module.exports = connect(
  (state) -> state.todoApp.VisibilityTodoRemove
  {}
  TodoApp
)
