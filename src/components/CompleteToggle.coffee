echo = -> console.log arguments
{
  cfx
  Styl
  Comps
} = require 'cfx.rn'
{
  View
  Text

  TouchableOpacity
} = Comps

styles = Styl
  button:
    width: 20
    height: 20
    borderRadius: 8
  active:
    backgroundColor: '#81c04d'
  inactive:
    backgroundColor: 'gray'

module.exports = cfx

  toggleChecked: -> @props.toggleChecked()

  getStyle: ->
    if @props.checked
    then styles.active
    else styles.inactive

  render: ->

    TouchableOpacity
      style: [
        styles.button
        @getStyle()
      ]
      onPress: @toggleChecked
