echo = -> console.log arguments
{
  cfx
  Styl
  Comps
  connect
} = require 'cfx.rn'

{
  View
  Text
} = Comps

styles = Styl
  container:
    flex: 1

TodoInfo = cfx ->

  View style: styles.container
  ,
    Text {}
    , 'Hello World!!!'

module.exports = connect(
  (state) -> state
  {}
  TodoInfo
)
