require 'tower'
require '../../lib/beer_can'

File  = require('pathfinder').File

global.chai   = require 'chai'
global.assert = chai.assert
global.expect = chai.expect
global.test   = it
global.sinon  = require 'sinon'
global.async  = require 'async'
global.cb     = true

Tower.env             = "test"
