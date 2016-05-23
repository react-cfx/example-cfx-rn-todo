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

  appbar:
    backgroundColor: '#81c04d'
    paddingTop: 30
    flexDirection: 'row'
    justifyContent: 'space-between'

  logotext:
    color: '#fff'
    fontWeight: 'bold'
    fontSize: 20
    paddingLeft: 10

  button:
    width: 80

  text:
    color: '#fff'
    textAlign: 'center'

AppBar = cfx

  render: (props, state) ->

    View style: styles.appbar
    ,
      Text style: styles.logotext
      , 'Todos App'
    ,
      TouchableOpacity style: styles.button
      ,
        Text style: styles.text
        , 'Settings'

module.exports = AppBar
