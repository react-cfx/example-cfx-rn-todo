echo = -> console.log arguments
{ assign } = Object
{
  cfx
  Styl
  Comps
  connect
} = require 'cfx.rn'
{
  View
  Text

  TouchableOpacity
} = Comps

{
  setVisibilityTodoRemove
  setVisibilityAllToRemove
} = require '../actions/index'

constants = require '../constants/index'
{
  SHOW_TODO_LIST
  SHOW_TODO_REMOVE
  SELECT_ALL_TO_REMOVE
  CANCEL_ALL_TO_REMOVE
} = constants.types

{
  capitalize
  filterToLocalFilter
} = require '../helper/index'

styles = Styl

  toolbar:
    backgroundColor: '#81c04d'
    paddingTop: 30
    paddingBottom: 10
    flexDirection: 'row'
  title:
    flex: 1
    color: '#fff'
    textAlign: 'center'
    fontWeight: 'bold'

  button:
    width: 50
  text:
    color: '#fff'
    textAlign: 'center'

TitleBar = cfx

  _leftButtonText: (VisibilityTodoRemove) ->
    switch VisibilityTodoRemove
      when SHOW_TODO_LIST
      then 'Del'
      when SHOW_TODO_REMOVE
      then 'Back'
      else return # TODO throw

  _rightButtonText: (VisibilityTodoRemove) ->
    switch VisibilityTodoRemove
      when SHOW_TODO_LIST
      then 'Add'
      when SHOW_TODO_REMOVE
      then 'All'
      else return # TODO throw

  constructor: (props, state) ->
    { VisibilityTodoRemove } = state
    @state =
      state: state
      leftButtonText: @_leftButtonText VisibilityTodoRemove
      rightButtonText: @_rightButtonText VisibilityTodoRemove
    @

  toggleDelAction: ->
    { VisibilityTodoRemove } = @state.state
    { setVisibilityTodoRemove } = @props.actions
    switch VisibilityTodoRemove
      when SHOW_TODO_LIST
      then setVisibilityTodoRemove SHOW_TODO_REMOVE
      when SHOW_TODO_REMOVE
      then setVisibilityTodoRemove SHOW_TODO_LIST
      else return # TODO throw

  componentWillReceiveProps: (nextProps) ->
    currentState = @state.state
    nextState = nextProps.state
    if (
      nextState.VisibilityTodoRemove isnt currentState.VisibilityTodoRemove or
      nextState.VisibilityAllToRemove isnt currentState.VisibilityAllToRemove
    )
      @setState
        state: nextProps.state
        leftButtonText: @_leftButtonText nextState.VisibilityTodoRemove
        rightButtonText: @_rightButtonText nextState.VisibilityTodoRemove

  toggleSelectAllToRemove: ->
    { setVisibilityAllToRemove } = @props.actions
    { VisibilityAllToRemove } = @state.state
    switch VisibilityAllToRemove
      when CANCEL_ALL_TO_REMOVE
      then setVisibilityAllToRemove SELECT_ALL_TO_REMOVE
      when SELECT_ALL_TO_REMOVE
      then setVisibilityAllToRemove CANCEL_ALL_TO_REMOVE
      else return # TODO throw

  handleRightButton: ->
    if @state.state.VisibilityTodoRemove is SHOW_TODO_REMOVE
      @toggleSelectAllToRemove.call @
    # else

  render: (props, state) ->
    TitlePrefix = capitalize filterToLocalFilter state.VisibilityFilter

    View style: styles.toolbar
    ,
      TouchableOpacity
        style: styles.button
        onPress: @toggleDelAction
      ,
        Text style: styles.text
        , @state.leftButtonText
    ,
      Text style: styles.title
      , "#{TitlePrefix} Todos"
    ,
      TouchableOpacity
        style: styles.button
        onPress: @handleRightButton.bind @
      ,
        Text style: styles.text
        , @state.rightButtonText

module.exports = connect(
  (state) ->
    VisibilityTodoRemove: state.todoApp.VisibilityTodoRemove
    VisibilityAllToRemove: state.todoApp.VisibilityAllToRemove
    VisibilityFilter: state.todoApp.VisibilityFilter
  {
    setVisibilityTodoRemove
    setVisibilityAllToRemove
  }
  TitleBar
)
