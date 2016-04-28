{
  RN
  cfx
  cfxify
  Styl
  Comps
  Platform
  connect
} = require 'cfx.rn'

{
  View
  Text
} = Comps

{ addTodoState } = require '../actions/index'

{ initial } = require '../initials/index'

TextInput = cfxify RN.TextInput

styles = Styl
  row:
    flexDirection: 'column'
    paddingLeft: 40
    paddingRight: 40
  input:
    height: 40
    flex: 1
  border:
    flex: 1
    height: 1
    backgroundColor: 'gray'

AddTodo = cfx

  constructor: ->
    @state =
      focused: false
      value: null

  renderBorder: ->
    if @state.focused
      View style: styles.border

  onSubmit: (props, state) ->
    {
      addTodoState
    } = @props.actions
    addTodoState
      todo: initial.todo @state.value

  onText: (text) ->
    @state.value = text
    @setState @state

  onFocused: () ->

    @state.focused = true
    @setState @state

  onBlurred: () ->

    @state.focused = false
    @setState @state

  render: ->

    View style: styles.row
    ,
      TextInput
        style: styles.input
        onChangeText: @onText
        onSubmitEditing: @onSubmit
        onFocus: @onFocused
        onBlur: @onBlurred
        placeholder: 'Add a new todo...'
    ,
      @renderBorder() if Platform.OS is 'ios'

module.exports = connect(
  (state) -> state.todoApp.Todos
  { addTodoState }
  AddTodo
)
