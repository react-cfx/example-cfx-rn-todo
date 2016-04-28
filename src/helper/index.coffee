capitalize = (word) ->
  lower = word.toLowerCase()

  lower
  .slice 0, 1
  .toUpperCase() +
  lower.slice 1

filterToLocalFilter = (state) ->
  switch state
    when 'SHOW_TODO_ALL'
    then 'ALL'
    when 'SHOW_TODO_COMPLETED'
    then 'COMPLETED'
    when 'SHOW_TODO_ACTIVE'
    then 'INCOMPLETE'

localFilterToFilter = (state) ->
  switch state
    when 'ALL'
    then 'SHOW_TODO_ALL'
    when 'COMPLETED'
    then 'SHOW_TODO_COMPLETED'
    when 'INCOMPLETE'
    then 'SHOW_TODO_ACTIVE'

module.exports = {
  capitalize
  filterToLocalFilter
  localFilterToFilter
}
