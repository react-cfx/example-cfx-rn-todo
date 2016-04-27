echo = -> console.log arguments
{
  RN
  cfx
  Styl
  Comps
  connect
} = require 'cfx.rn'
{
  View
  Text
  ListView

  TouchableHighlight
} = Comps

CompleteToggle = require './CompleteToggle'
AddTodo = require './AddTodo'

styles = Styl
  container:
    flex: 1
    # alignItems: 'center'
    # justifyContent: 'center'
  row:
    flexDirection: 'row'
    paddingTop: 20
    paddingBottom: 20
    paddingLeft: 20
    paddingRight: 20
  viewRow:
    flexDirection: 'row'
    alignItems: 'center'
  addTodo:
    paddingLeft: 30
  text:
    flex: 1
    fontSize: 16
    marginLeft: 10

TodoList = cfx do ->

  getTodosWithTemplate = (todos) ->
    todos.concat [
      addTodo: true
    ]

  constructor: (props, state) ->

    todos = state

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state =
      dataSource: ds.cloneWithRows getTodosWithTemplate todos

    return

  componentWillReceiveProps: (nextProps) ->
    unless nextProps.todos is @props.todos
      @setState
        dataSource: @state.dataSource.cloneWithRows(
          @getTodosWithTemplate nextProps.todos
        )

  renderTodoItem: (todo) ->

    TouchableHighlight
      style: styles.row
      underlayColor: "#e4f2d9"
      key: todo.id
    ,
      View style: styles.viewRow
      ,
        CompleteToggle
          style: styles.toggle
          checked: todo.completed
      ,
        Text style: styles.text
        , todo.text

  renderRow: (todo) ->
    if todo.addTodo
      AddTodo()
    else
      @renderTodoItem todo

  render: ->
    ListView
      style: styles.container
      dataSource: @state.dataSource
      renderRow: @renderRow

module.exports = connect(
  (state) ->
    state.todoApp.Todos
  {}
  TodoList
)
