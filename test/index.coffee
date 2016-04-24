#!/usr/bin/env coffee
echo = console.log
dd = require 'ddeyes'
require 'shelljs/make'

{ createStore } = require 'cfx.redux'

{
  setVisibilityFilter
  setVisibilityAddModal
} = require '../src/actions/Visibility'

constants = require '../src/constants/Visibility'
{
  SHOW_TODO_ALL
  SHOW_TODO_COMPLETED
  SHOW_TODO_ACTIVE
  ADD_MODAL_OPENED
  ADD_MODAL_CLOSED
} = constants.types

reducers = require '../src/reducers/Visibility'

store = createStore
  todoApp: reducers

target.all = ->

  dd store.getState()

  unsubscribe = store.subscribe ->
    dd store.getState()

  store.dispatch setVisibilityFilter
    filter: SHOW_TODO_COMPLETED

  store.dispatch setVisibilityAddModal
    addMoal: ADD_MODAL_OPENED

  unsubscribe()
