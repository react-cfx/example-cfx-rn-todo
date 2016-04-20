{
  RN
  cfx
  Styl
  Comps
} = require 'cfx.rn'
{
  View
  Text
  ListView

  TouchableHighlight
} = Comps

CompleteToggle = require './CompleteToggle'

styles = Styl
  container:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'
  row:
    flexDirection: 'row'
    paddingTop: 20
    paddingBottom: 20
    paddingLeft: 20
    paddingRight: 20
  templateRow:
    paddingLeft: 30
  text:
    flex: 1
    fontSize: 16
    marginLeft: 10

module.exports = cfx

  constructor: ->

    todos = [
        id: 'cin89hdq400005e392v1cm1rp'
        text: 'Learn about actions'
        completed: false
      ,
        id: 'cin89hdr400015e39wgk31nq9'
        text: 'Learn about reducers'
        completed: true
      ,
        id: 'cin89hdrl00025e393jdh18vy'
        text: 'Learn about redux'
        completed: false
      ,
        id: 'cin89hdry00035e399jnsz3bz'
        text: 'Learn about sagas'
        completed: false
    ]

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state =
      dataSource: ds.cloneWithRows todos

    return

  renderTodoItem: (todo) ->

    TouchableHighlight
      underlayColor: "#e4f2d9"
      key: todo.id
      style: styles.row
    ,
      View
        style:
          flexDirection: 'row'
          flex: 1
          alignItems: 'center'
      ,
        CompleteToggle
          style: styles.toggle
          checked: todo.completed
      ,
        Text style: styles.text
        , todo.text

  renderRow: (todo) ->
    @renderTodoItem todo

  render: ->
    ListView
      dataSource: @state.dataSource
      renderRow: @renderRow
