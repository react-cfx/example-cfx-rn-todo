echo = -> console.log arguments

{
  RN
  cfx
  Styl
  Comps
  connect
} = require 'cfx.rn'

{
  TouchableOpacity
  View
  Text
} = Comps

{ setVisibilityFilter } = require '../actions/Visibility'

{ capitalize } = require '../helper/index'

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

{
  filterToLocalFilter
  localFilterToFilter
} = require '../helper/index'

VisibilityFilter = cfx

  constructor: (props, state) ->

    @state =
      activeFilter: filterToLocalFilter state

    @

  componentWillReceiveProps: (nextProps) ->
    @setState
      activeFilter: filterToLocalFilter nextProps.state

  render: (props, state) ->

    selfState = @state

    { setVisibilityFilter } = props.actions

    renderFilters = [
      'ALL'
      'COMPLETED'
      'INCOMPLETE'
    ].reduce (result, filter, index, array) ->

      buttonStyle =
        if selfState.activeFilter is filter
        then [
          styles.button
          styles.current
        ]
        else styles.button

      result.push(

        TouchableOpacity
          style: buttonStyle
          onPress: ->
            setVisibilityFilter localFilterToFilter filter
        ,
          Text style: styles.text
          , capitalize filter

      )

      result

    , []

    View.apply @
    , do ->
      renderFilters.unshift
        style: styles.bar
      renderFilters

module.exports = connect(
  (state) ->
    state.todoApp.VisibilityFilter
  { setVisibilityFilter }
  VisibilityFilter
)
