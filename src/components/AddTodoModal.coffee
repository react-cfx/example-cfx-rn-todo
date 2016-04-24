{
  RN
  cfx
  cfxify

  Styl
  Comps
} = require 'cfx.rn'
{
  View
  Text
  TouchableOpacity
} = Comps

TextInput = cfxify RN.TextInput

styles = Styl
  container:
    flex: 1
  input:
    height: 40
    borderColor: 'gray'
    borderWidth: 1
    paddingLeft: 10
    paddingRight: 10
  button:
    height: 40
    backgroundColor: '#81c04d'
    justifyContent: 'center'
    marginTop: 20
  buttonText:
    color: '#fff'
    textAlign: 'center'

  content:
    flex: 1
    justifyContent: 'center'
    paddingLeft: 20
    paddingRight: 20

  toolbar:
    backgroundColor: '#81c04d'
    paddingTop: 30
    paddingBottom: 10
    flexDirection: 'row'
  toolbarButton:
    width: 50
  toolbarText:
    color: '#fff'
    textAlign: 'center'
  toolbarTitle:
    flex: 1
    color: '#fff'
    textAlign: 'center'
    fontWeight: 'bold'

module.exports = cfx

  constructor: ->

    @state =
      value: null

  # handleOnChange = (text) ->
  #
  #   @setState value: text
  #
  # addTodo = ->
  #
  #   @props.addTodo @state.value
  #   @props.hideModal()
  #   @setState value: null

  render: ->

    { hideModal } = @props

    View style: styles.container
    ,
      View style: styles.toolbar
      ,
        Text style: styles.toolbarButton
      ,
        Text style: styles.toolbarTitle
        , 'Add Todo'
      ,
        TouchableOpacity
          style: styles.toolbarButton
          onPress: hideModal
        ,
          Text style: styles.toolbarText
          , 'Cancel'
    ,
      View style: styles.content
      ,
        TextInput
          style: styles.input
          # onChangeText: @handleOnChange
          value: @state.value
      ,
        TouchableOpacity
          style: styles.button
          # onPress: @addTodo
        ,
          Text style: styles.buttonText
          , 'Add Todo'
