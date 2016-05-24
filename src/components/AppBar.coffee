echo = -> console.log arguments
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
  setVisibilitySettings
} = require '../actions/index'
constants = require '../constants/index'
{
  SETTINGS_OPENED
  SETTINGS_CLOSEED
} = constants.types

styles = Styl

  appbar:
    backgroundColor: '#81c04d'
    paddingTop: 30
    paddingBottom: 10
    flexDirection: 'row'
    justifyContent: 'space-between'

  logotext:
    color: '#fff'
    fontWeight: 'bold'
    fontSize: 20
    paddingLeft: 10

  button:
    paddingTop: 10
    width: 80

  text:
    color: '#fff'
    textAlign: 'center'

AppBar = cfx

  constructor: (props, state) ->
    { VisibilitySettings } = state
    @state = {
      VisibilitySettings
    }
    @

  toggleSettingsModal: ->
    { VisibilitySettings } = @state
    { setVisibilitySettings } = @props.actions
    switch VisibilitySettings
      when SETTINGS_OPENED
      then setVisibilitySettings SETTINGS_CLOSEED
      when SETTINGS_CLOSEED
      then setVisibilitySettings SETTINGS_OPENED
      else return # TODO throw

  componentWillReceiveProps: (nextProps) ->
    Settings =
      current: @state.VisibilitySettings
      next: nextProps.state.VisibilitySettings
    if Settings.next isnt Settings.current
      @setState
        VisibilitySettings: Settings.next

  render: (props, state) ->

    View style: styles.appbar
    ,
      Text style: styles.logotext
      , 'Todos App'
    ,
      TouchableOpacity
        style: styles.button
        onPress: @toggleSettingsModal
      ,
        Text style: styles.text
        , 'Settings'

module.exports = connect(
  (state) ->
    VisibilitySettings: state.todoApp.VisibilitySettings
  { setVisibilitySettings }
  AppBar
)
