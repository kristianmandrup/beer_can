require '../,,/lib/beer_can'
File  = require('pathfinder').File
# require './secrets'

global.chai   = require 'chai'
global.assert = chai.assert
global.expect = chai.expect
global.test   = it
global.sinon  = require 'sinon'
global.async  = require 'async'
global.cb     = true

# Tower.root            = process.cwd() + "/test/test-app"
# Tower.publicPath      = Tower.root + "/public"
Tower.env             = "test"
