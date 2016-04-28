{ initials } = require 'cfx.example-cfx-redux-todo'

{
  initial
  initialState
  normalizer
} = initials

Todos = initialState.todos.concat [
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

module.exports = {
  initial
  initialState: {
    Todos
  }
  normalizer
}
