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
} = require '../actions/index'

constants = require '../constants/index'
{
  SHOW_TODO_LIST
  SHOW_TODO_REMOVE
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
    content =
      current: @state.state.VisibilityTodoRemove
      next: nextProps.state.VisibilityTodoRemove
    unless content.next is content.current
      @setState
        state: nextProps.state
        leftButtonText: @_leftButtonText content.next
        rightButtonText: @_rightButtonText content.next

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
        # onPress: showModal
      ,
        Text style: styles.text
        , @state.rightButtonText

module.exports = connect(
  (state) ->
    VisibilityTodoRemove: state.todoApp.VisibilityTodoRemove
    VisibilityFilter: state.todoApp.VisibilityFilter
  { setVisibilityTodoRemove }
  TitleBar
)
