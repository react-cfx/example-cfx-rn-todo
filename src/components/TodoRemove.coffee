echo = -> console.log arguments
{ assign } = Object
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
  TouchableOpacity
} = Comps

CompleteToggle = require './CompleteToggle'
AddTodo = require './AddTodo'

{ getVisibleTodos } = require '../selectors/index'

{ SHOW_TODO_COMPLETED } = (
  require '../constants/Visibility'
).types

{
  modifyTodoState
  removeTodoState
} = require '../actions/index'

styles = Styl
  container:
    flex: 1
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
    borderColor: '#e4f2d9'
    borderWidth: 1
    borderRadius: 5
    backgroundColor: '#81c04d'

    shadowColor: "#81c04d"
    shadowOffset:
      width: 2
      height: 2
    shadowOpacity: 0.5
    shadowRadius: 5

  buttonText:
    padding: 5
    color: "white"

  text:
    flex: 1
    fontSize: 16
    marginLeft: 10

TodoList = cfx do ->

  getTodosWithTemplate = (todos) ->
    unless todos.length is 0
      todos.concat [
        submitButton: true
      ]
    else todos

  setWaitDel = (todos, todoId) ->
    todos.reduce (result, current, index, array) ->
      result.push assign {}
      , current
      , waitDel:
        if current.waitDel
        then (
          if todoId? and todoId is current.id
          then !current.waitDel
          else current.waitDel
        )
        else (
          if todoId? and todoId is current.id
          then true
          else false
        )

      result
    , []

  newState = (ds, state, todoId) ->
    todos = setWaitDel state.todos, todoId
    state: state
    todos: todos
    dataSource: ds.cloneWithRows(
      getTodosWithTemplate getVisibleTodos(
        visibilityFilter: state.visibilityFilter
        todos: todos
      )
    )

  constructor: (props, state) ->

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state = newState ds, state
    @

  componentWillReceiveProps: (nextProps) ->

    selfTodos = @state.todos.slice()

    todos = nextProps.state.todos.reduce (
      result
      current
      index
      array
    ) ->
      for selfTodo in selfTodos
        if current.id is selfTodo.id
          if selfTodo.waitDel
            result.push assign {}
            , current
            , waitDel: selfTodo.waitDel
          else
            result.push current
      result
    , []

    @setState newState @state.dataSource
    , {
      visibilityFilter: nextProps.state.visibilityFilter
      todos
    }

  toggleWaitDel: (todoId) ->

    @setState newState @state.dataSource
    ,
      visibilityFilter: @state.state.visibilityFilter
      todos: @state.todos
    , todoId

  renderTodoItem: (todo, sectionID, rowID) ->

    textStyle =
      if todo.waitDel
      then [
        styles.text
        color: 'red'
        textDecorationLine: 'line-through'
      ]
      else styles.text

    TouchableOpacity
      style: styles.row
      underlayColor: "#e4f2d9"
      key: todo.id
      onPress: @toggleWaitDel.bind @, todo.id
    ,
      View style: styles.viewRow
      ,
        CompleteToggle
          style: styles.toggle
          checked: todo.completed
      ,
        Text style: textStyle
        , todo.text

  removeTodos: (todoId) ->
    { removeTodoState } = @props.actions
    todos = getVisibleTodos(
      visibilityFilter: @state.state.visibilityFilter
      todos: @state.todos
    )
    todos.forEach (current, index, array) ->
      if current.waitDel
        removeTodoState
          todoId: current.id

  renderRow: (todo) ->
    if todo.submitButton

      View
        style:
          marginTop: 20
          alignItems: 'center'
      ,
        TouchableOpacity
          style: styles.button
          onPress: @removeTodos.bind @, todo.id
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
  {
    modifyTodoState
    removeTodoState
  }
  TodoList
)
