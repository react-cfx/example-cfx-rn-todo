echo = -> console.log arguments
{
  cfx
  cfxify
  Comps
  connect
} = require 'cfx.rn'
{ View } = Comps

AppBar = require '../components/AppBar'
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

    View style:
      flex: 1
      flexDirection: 'column'
    ,
      View {}
      ,
        AppBar {}
    ,
      View style: flex: 1
      ,
        TitleBar {}
      ,
        @state.Container {}
      ,
        unless @state.VisibilityContainer is SHOW_TODO_INFO
          Filters {}

module.exports = connect(
  (state) -> state.todoApp.VisibilityContainer
  {}
  TodoApp
)
