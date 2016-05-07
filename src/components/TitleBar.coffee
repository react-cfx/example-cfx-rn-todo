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
  setVisibilityContainer
  setVisibilityAllToRemove
} = require '../actions/index'

constants = require '../constants/index'
{
  SHOW_TODO_LIST
  SHOW_TODO_REMOVE
  SHOW_TODO_INFO
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

  _leftButtonText: (VisibilityContainer) ->
    switch VisibilityContainer
      when SHOW_TODO_LIST
      then 'Del'
      when SHOW_TODO_REMOVE, SHOW_TODO_INFO
      then 'Back'
      else return # TODO throw

  _rightButtonText: (VisibilityContainer) ->
    switch VisibilityContainer
      when SHOW_TODO_LIST
      then 'Add'
      when SHOW_TODO_REMOVE
      then 'All'
      when SHOW_TODO_INFO
      then 'Edit'
      else return # TODO throw

  constructor: (props, state) ->
    { VisibilityContainer } = state
    @state =
      state: state
      leftButtonText: @_leftButtonText VisibilityContainer
      rightButtonText: @_rightButtonText VisibilityContainer
    @

  componentWillReceiveProps: (nextProps) ->
    currentState = @state.state
    nextState = nextProps.state
    if (
      nextState.VisibilityContainer isnt currentState.VisibilityContainer or
      nextState.VisibilityAllToRemove isnt currentState.VisibilityAllToRemove
    )
      @setState
        state: nextProps.state
        leftButtonText: @_leftButtonText nextState.VisibilityContainer
        rightButtonText: @_rightButtonText nextState.VisibilityContainer

  newTodo: ->
    { setVisibilityContainer } = @props.actions
    setVisibilityContainer SHOW_TODO_INFO

  toggleSelectAllToRemove: ->
    { setVisibilityAllToRemove } = @props.actions
    { VisibilityAllToRemove } = @state.state
    switch VisibilityAllToRemove
      when CANCEL_ALL_TO_REMOVE
      then setVisibilityAllToRemove SELECT_ALL_TO_REMOVE
      when SELECT_ALL_TO_REMOVE
      then setVisibilityAllToRemove CANCEL_ALL_TO_REMOVE
      else return # TODO throw

  toggleDelAction: ->
    { VisibilityContainer } = @state.state
    { setVisibilityContainer } = @props.actions
    switch VisibilityContainer
      when SHOW_TODO_LIST
      then setVisibilityContainer SHOW_TODO_REMOVE
      when SHOW_TODO_REMOVE
      then setVisibilityContainer SHOW_TODO_LIST
      else return # TODO throw

  handleLeftButton: ->
    { VisibilityContainer } = @state.state
    { setVisibilityContainer } = @props.actions
    switch VisibilityContainer
      when SHOW_TODO_LIST, SHOW_TODO_REMOVE
      then @toggleDelAction()
      when SHOW_TODO_INFO
      then setVisibilityContainer SHOW_TODO_LIST
      else return # TODO throw

  handleRightButton: ->
    { VisibilityContainer } = @state.state
    switch VisibilityContainer
      when SHOW_TODO_REMOVE
      then @toggleSelectAllToRemove()
      when SHOW_TODO_LIST
      then @newTodo()
      else return # TODO throw

  _titleText: (VisibilityContainer, VisibilityFilter) ->
    if VisibilityContainer is SHOW_TODO_INFO
      'Todo Info'
    else
      TitlePrefix = capitalize filterToLocalFilter VisibilityFilter
      "#{TitlePrefix} Todos"

  render: (props, state) ->

    View style: styles.toolbar
    ,
      TouchableOpacity
        style: styles.button
        onPress: @handleLeftButton
      ,
        Text style: styles.text
        , @state.leftButtonText
    ,
      Text style: styles.title
      ,
        @_titleText state.VisibilityContainer
        , state.VisibilityFilter
    ,
      TouchableOpacity
        style: styles.button
        onPress: @handleRightButton
      ,
        Text style: styles.text
        , @state.rightButtonText

module.exports = connect(
  (state) ->
    VisibilityContainer: state.todoApp.VisibilityContainer
    VisibilityAllToRemove: state.todoApp.VisibilityAllToRemove
    VisibilityFilter: state.todoApp.VisibilityFilter
  {
    setVisibilityContainer
    setVisibilityAllToRemove
  }
  TitleBar
)
