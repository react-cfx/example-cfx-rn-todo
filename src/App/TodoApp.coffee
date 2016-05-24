echo = -> console.log arguments
{
  cfx
  cfxify
  Comps
  connect
} = require 'cfx.rn'
{ View } = Comps

AppBar = require '../components/AppBar'
Settings = require '../components/Settings'
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
  SETTINGS_OPENED
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
      VisibilityContainer: state.VisibilityContainer
      Container: @_Container state.VisibilityContainer
      VisibilitySettings: state.VisibilitySettings
    @

  componentWillReceiveProps: (nextProps) ->

    unless @state.VisibilityContainer is nextProps.state.VisibilityContainer
      @setState
        VisibilityContainer: nextProps.state.VisibilityContainer
        Container: @_Container nextProps.state.VisibilityContainer

    unless @state.VisibilitySettings is nextProps.state.VisibilitySettings
      @setState
        VisibilitySettings: nextProps.state.VisibilitySettings

  render: (props, state) ->

    View style:
      flex: 1
      flexDirection: 'column'
    ,
      View {}
      ,
        AppBar {}
    ,
      ( ->
        if @state.VisibilitySettings is SETTINGS_OPENED
          View style: flex: 1
          ,
            Settings {}
        else
          View style: flex: 1
          ,
            TitleBar {}
          ,
            @state.Container {}
          ,
            unless @state.VisibilityContainer is SHOW_TODO_INFO
              Filters {}
      ).call @

module.exports = connect(
  (state) ->
    VisibilityContainer: state.todoApp.VisibilityContainer
    VisibilitySettings: state.todoApp.VisibilitySettings
  {}
  TodoApp
)
