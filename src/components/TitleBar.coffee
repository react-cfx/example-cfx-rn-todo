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
  toolbar:
    backgroundColor: '#81c04d'
    paddingTop: 30
    paddingBottom: 10
    flexDirection: 'row'
  title:
    flex: 1
    color: '#fff'
    textAlign: 'center'
    fontWeight: 'bold'

module.exports = cfx ->

  View style: styles.toolbar
  ,
    Text style: styles.title
    , "Todos"
