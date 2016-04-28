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

{
  capitalize
  filterToLocalFilter
} = require '../helper/index'

TitleBar = cfx (props, state) ->

  View style: styles.toolbar
  ,
    Text style: styles.title
    , "#{capitalize filterToLocalFilter state} Todos"

module.exports = connect(
  (state) -> state.todoApp.VisibilityFilter
  {}
  TitleBar
)
