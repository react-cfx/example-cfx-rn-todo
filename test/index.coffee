#!/usr/bin/env coffee
echo = console.log
dd = require 'ddeyes'
require 'shelljs/make'

constants = require '../src/constants/index'

target.all = ->

  dd constants
