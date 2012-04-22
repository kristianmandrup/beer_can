require '../config'

describe 'BeerCan.ModelMixin', ->
  beforeEach ->
  	@model = {}
  	@model extends BeerCan.ModelMixin
