echo = -> console.log arguments
{
  cfx
  Styl
  Comps
} = require 'cfx.rn'
{
  View
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

  render: (props, state) ->
    style = [
      styles.button
      @getStyle()
    ]
    if props.toggleChecked
      TouchableOpacity
        style: style
        onPress: @toggleChecked
    else
      View style: style
