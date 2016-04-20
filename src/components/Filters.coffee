echo = -> console.log arguments

{
  RN
  cfx
  Styl
  Comps
} = require 'cfx.rn'

{
  TouchableOpacity
  View
  Text
} = Comps

styles = Styl
  bar:
    backgroundColor: '#81c04d'
    flexDirection: 'row'
  button:
    paddingTop: 20
    paddingBottom: 20
    flex: 1
  text:
    flex: 1
    color: '#fff'
    textAlign: 'center'
    fontWeight: 'bold'
  current:
    backgroundColor: '#70a743'

module.exports = cfx

  constructor: ->

    @state =
      activeFilter: 'ALL'

    @

  render: ->

    state = @state

    renderFilters = [
      'ALL'
      'COMPLETED'
      'INCOMPLETE'
    ].reduce (result, filter, index, array) ->

      buttonStyle =
        if state.activeFilter is filter
        then [
          styles.button
          styles.current
        ]
        else styles.button

      result.push(

        TouchableOpacity style: buttonStyle
        ,
          Text style: styles.text
          , filter

      )

      result

    , []

    View.apply @
    , do ->
      renderFilters.unshift
        style: styles.bar
      renderFilters
