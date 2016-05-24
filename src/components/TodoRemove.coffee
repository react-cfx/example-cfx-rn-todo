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

# {
#   SHOW_TODO_COMPLETED
#   SELECT_ALL_TO_REMOVE
#   CANCEL_ALL_TO_REMOVE
# } = (
#   require '../constants/Visibility'
# ).types

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

TodoList = cfx

  _getTodosWithTemplate: (todos) ->
    unless todos.length is 0
      todos.concat [
        submitButton: true
      ]
    else todos

  _setWaitDel: (todos, todoId) ->
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

  _newState: (ds, state, todoId) ->
    todos = @_setWaitDel state.todos, todoId
    state: state
    todos: todos
    dataSource: ds.cloneWithRows(
      @_getTodosWithTemplate getVisibleTodos(
        visibilityFilter: state.visibilityFilter
        todos: todos
      )
    )

  constructor: (props, state) ->

    ds = new RN.ListView.DataSource
      rowHasChanged: (r1, r2) -> r1 isnt r2

    @state = @_newState ds, state
    @

  getTodosSwitchVisibilityFilter: (oldTodos, newTodos) ->

    newTodos.reduce (
      result
      current
      index
      array
    ) ->
      for oldTodo in oldTodos
        if current.id is oldTodo.id
          if oldTodo.waitDel is true
            result.push assign {}
            , current
            , waitDel: oldTodo.waitDel
          else
            result.push assign {}
            , current
            , waitDel: false
          return result
      result.push current
      result
    , []

  getTodosSwitchVisibilityAllToRemoveA: (
    stateTodos
    waitDels
  ) ->
    count = 0
    for todo in stateTodos
      for waitDel in waitDels
        if waitDel.id is todo.id
          if todo.waitDel is true
            count++

    SelectOrCancelAll = (todos, waitDelBool) ->
      todos.reduce (
        result
        current
        index
        array
      ) ->
        for waitDel in waitDels
          if waitDel.id is current.id
            result.push assign {}
            , current
            , waitDel: waitDelBool
            return result
        result.push current
        result
      , []

    if count is waitDels.length # Cancel All
      SelectOrCancelAll stateTodos, false
    else # Select All
      SelectOrCancelAll stateTodos, true

  componentWillReceiveProps: (nextProps) ->

    if (
      nextProps.state.visibilityFilter isnt @state.state.visibilityFilter or
      @state.state.todos.length isnt nextProps.state.todos.length
    )

      todos = @getTodosSwitchVisibilityFilter @state.todos
      , nextProps.state.todos

      @setState @_newState @state.dataSource
      ,
        assign {}
        , nextProps.state
        , todos: todos

    if nextProps.state.visibilityAllToRemove isnt @state.state.visibilityAllToRemove

      waitDels = getVisibleTodos nextProps.state

      todos = @getTodosSwitchVisibilityAllToRemoveA @state.todos
      , waitDels

      @setState @_newState @state.dataSource
      ,
        assign {}
        , nextProps.state
        , todos: todos

  toggleWaitDel: (todoId) ->

    @setState @_newState @state.dataSource
    ,
      assign {}
      , @state.state
      , todos: @state.todos
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

  removeTodos: ->
    { removeTodoState } = @props.actions
    todos = getVisibleTodos
      visibilityFilter: @state.state.visibilityFilter
      todos: @state.todos
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
          onPress: @removeTodos.bind @
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
    visibilityAllToRemove: state.todoApp.VisibilityAllToRemove
    todos: state.todoApp.Todos
  {
    modifyTodoState
    removeTodoState
  }
  TodoList
)
