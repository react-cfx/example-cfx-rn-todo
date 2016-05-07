echo = -> console.log arguments
{
  cfx
  cfxify
  Styl
  Comps
  connect
} = require 'cfx.rn'
{ View } = Comps

TitleBar = require '../components/TitleBar'
TodoList = require '../components/TodoList'
TodoRemove = require '../components/TodoRemove'
TodoInfo = require '../components/TodoInfo'
Filters = require '../components/Filters'

constants = require '../constants/index'
{
  SHOW_TODO_LIST
  SHOW_TODO_REMOVE
  SHOW_TODO_INFO
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

  _Container: (VisibilityContainer) ->
    switch VisibilityContainer
      when SHOW_TODO_LIST
      then TodoList
      when SHOW_TODO_REMOVE
      then TodoRemove
      when SHOW_TODO_INFO
      then TodoInfo
      else return # TODO throw

  constructor: (props, state) ->
    @state =
      VisibilityContainer: state
      Container: @_Container state
    @

  componentWillReceiveProps: (nextProps) ->

    unless @state.VisibilityContainer is nextProps.state
      @setState
        VisibilityContainer: nextProps.state
        Container: @_Container nextProps.state

  render: (props, state) ->

    View style: styles.container
    ,
      TitleBar style: styles.title
    ,
      @state.Container style: styles.list
    ,
      unless @state.VisibilityContainer is SHOW_TODO_INFO
        Filters style: styles.filters

module.exports = connect(
  (state) -> state.todoApp.VisibilityContainer
  {}
  TodoApp
)
