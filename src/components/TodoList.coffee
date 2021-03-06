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

{ getVisibleTodos } = require '../selectors/index'

{ SHOW_TODO_COMPLETED } = (
  require '../constants/Visibility'
).types

{ modifyTodoState } = require '../actions/index'

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

TodoList = cfx

  _getTodosWithTemplate: (todos, filter) ->
    unless filter is SHOW_TODO_COMPLETED
      todos.concat [
        addTodo: true
      ]
    else todos

  constructor: (props, state) ->

    todos = getVisibleTodos state

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state =
      todos: state.todos
      dataSource: ds.cloneWithRows(
        @_getTodosWithTemplate todos
        , state.visibilityFilter
      )

    return

  componentWillReceiveProps: (nextProps) ->
    todos = getVisibleTodos nextProps.state
    @setState
      todos: nextProps.state.todos
      dataSource: @state.dataSource.cloneWithRows(
        @_getTodosWithTemplate todos
        , nextProps.state.visibilityFilter
      )

  toggleChecked: (todoId) ->
    { modifyTodoState } = @props.actions
    { todos } = @state
    todos.forEach (
      todo
      index
      array
    ) ->
      if todo.id is todoId
        modifyTodoState
          index: index
          todo:
            completed: !todo.completed

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
          toggleChecked: @toggleChecked
          .bind @, todo.id
      ,
        Text style: styles.text
        , todo.text

  renderRow: (todo) ->
    if todo.addTodo
      AddTodo()
    else
      @renderTodoItem todo

  render: ->
    ds = @state.dataSource
    unless ds.getRowCount() is 0
      ListView
        style: styles.container
        dataSource: ds
        renderRow: @renderRow
    else
      View style: styles.container

module.exports = connect(
  (state) ->
    visibilityFilter: state.todoApp.VisibilityFilter
    todos: state.todoApp.Todos
  { modifyTodoState }
  TodoList
)
