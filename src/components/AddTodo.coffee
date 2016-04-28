{
  RN
  cfx
  cfxify
  Styl
  Comps
  Platform
} = require 'cfx.rn'

{
  View
  Text
} = Comps

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

module.exports = cfx

  constructor: ->
    @state =
      focused: false

  renderBorder: ->
    if @state.focused
      View style: styles.border

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
        # onChangeText: @onText
        # onSubmitEditing: @onSubmit
        onFocus: @onFocused
        onBlur: @onBlurred
        placeholder: 'Add a new todo...'
    ,
      @renderBorder() if Platform.OS is 'ios'
