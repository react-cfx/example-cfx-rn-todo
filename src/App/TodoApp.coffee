echo = -> console.log arguments
{
  RN
  cfx
  cfxify
  Styl
  Comps
  connect
} = require 'cfx.rn'
{
  View
} = Comps

actions =
  Visibility: require '../actions/Visibility'

TitleBar = require '../components/TitleBar'
TodoList = require '../components/TodoList'
Filters = require '../components/Filters'

styles = Styl

  container:
    flex: 1
    justifyContent: 'center'
  title:
    flex: 1
  list:
    flex: 1
  filters:
    flex: 1
  add:
    flex: 1

todoApp = cfx ->

  View style: styles.container
  ,
    TitleBar style: styles.title
  ,
    TodoList style: styles.list
  ,
    Filters style: styles.filters

module.exports = connect 'todoApp'
, actions.Visibility
, todoApp
