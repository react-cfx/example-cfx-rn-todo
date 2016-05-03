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

  button:
    flex: 1
    flexDirection: 'row'
    justifyContent: 'center'
    alignItems: 'center'

    width: 200
    height: 50
    borderColor: '#81c04d'
    borderWidth: 1
    borderRadius: 5
    backgroundColor: 'white'

    shadowColor: "#e4f2d9"
    shadowOffset:
      width: 2
      height: 2
    shadowOpacity: 0.5
    shadowRadius: 5

  buttonText:
    padding: 5
    color: "#81c04d"

  text:
    flex: 1
    fontSize: 16
    marginLeft: 10

TodoList = cfx do ->

  getTodosWithTemplate = (todos, filter) ->
    todos.concat [
      submitButton: true
    ]

  constructor: (props, state) ->

    todos = getVisibleTodos state

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state =
      todos: state.todos
      dataSource: ds.cloneWithRows(
        getTodosWithTemplate todos
        , state.visibilityFilter
      )

    return

  componentWillReceiveProps: (nextProps) ->
    todos = getVisibleTodos nextProps.state
    @setState
      todos: nextProps.state.todos
      dataSource: @state.dataSource.cloneWithRows(
        getTodosWithTemplate todos
        , nextProps.state.visibilityFilter
      )

  # toggleChecked: (todoId) ->
  #   { modifyTodoState } = @props.actions
  #   { todos } = @state
  #   todos.forEach (
  #     todo
  #     index
  #     array
  #   ) ->
  #     if todo.id is todoId
  #       modifyTodoState
  #         index: index
  #         todo:
  #           completed: !todo.completed

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
          # toggleChecked: @toggleChecked
          # .bind @, todo.id
      ,
        Text style: styles.text
        , todo.text

  renderRow: (todo) ->
    if todo.submitButton

      View
        style:
          marginTop: 20
          alignItems: 'center'
      ,
        TouchableHighlight
        ,
          View style: styles.button
          ,
            Text style: styles.buttonText
            , 'DELETE'

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
