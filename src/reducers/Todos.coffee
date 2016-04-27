{ reduxActions } = require 'cfx.redux-actions'
{
  handleAction
} = reduxActions

Todos = handleAction(
  ''
  next: (state, action) -> state
  throw: (state, action) ->
    throw new Error {
      state
      action
    }
)

module.exports = {
  Todos
}
