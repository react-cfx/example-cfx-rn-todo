echo = -> console.log.apply @, arguments

{
  cfx
  Styl
  Comps
} = require 'cfx.rn'

{
  TextInput
  View
} = Comps

styles = Styl
  row:
    flexDirection: 'column'
    paddingLeft: 40
    paddingRight: 10
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
      value: null

  renderBorder: ->
    View style: styles.border if @state.focused

  render: ->
    { addTodo } = @props

    View style: styles.row
    ,
      TextInput
        styles: styles.input
        placeholder: "Add a new todo..."
      , @renderBorder()
