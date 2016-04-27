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

stateToLocalState = (state) ->
  switch state
    when 'SHOW_TODO_ALL'
    then 'ALL'
    when 'SHOW_TODO_COMPLETED'
    then 'COMPLETED'
    when 'SHOW_TODO_ACTIVE'
    then 'INCOMPLETE'

localStateToState = (state) ->
  switch state
    when 'ALL'
    then 'SHOW_TODO_ALL'
    when 'COMPLETED'
    then 'SHOW_TODO_COMPLETED'
    when 'INCOMPLETE'
    then 'SHOW_TODO_ACTIVE'

VisibilityFilter = cfx

  constructor: (props, state) ->

    @state =
      activeFilter: stateToLocalState state

    @

  componentWillReceiveProps: (nextProps) ->
    @setState
      activeFilter: stateToLocalState nextProps.state

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
            setVisibilityFilter localStateToState filter
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

module.exports = connect(
  (state) ->
    state.todoApp.VisibilityFilter
  { setVisibilityFilter }
  VisibilityFilter
)
