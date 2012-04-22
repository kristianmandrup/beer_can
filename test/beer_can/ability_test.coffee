console.log 'Testing: BeerCan.Ability' 

describe 'BeerCan.Ability', ->
	beforeEach ->
    @ability = {}
    @ability.extends BeerCan.Ability 

  it "should be able to 'read' anything", ->
    @ability.can 'read', 'all'

    expect(@ability.can 'read', String).toBeTruthy()
    expect(@ability.can 'read', 123).toBeTruthy()


  it "should not have permission to do something it doesn't know about", ->
    expect(@ability.can 'foodfight', String).toBeFalsy()


  it "should pass true to `can` when non false/nil is returned in closure", ->
    @ability.can 'read', 'all'
    @ability.can 'read', String, (sym) ->
      "foo" 
    
    expect(@ability.can 'read', 'some_string').toBeTruthy()


  it "should pass nil to a closure when no instance is passed", ->
    @ability.can 'read', String, (sym) ->
      	sym.should be_nil
      	true

    expect(@ability.can 'read', String).toBeTruthy()


  it "should pass to previous rule, if closure returns false or nil", ->
    @ability.can 'read', String
    @ability.can 'read', Integer, (i) ->
      i < 5
    
    @ability.can 'read', Integer, (i) ->
      i > 10

    expect(@ability.can 'read', String).toBeTruthy()
    expect(@ability.can 'read', 11).toBeTruthy()
    expect(@ability.can 'read', 1).toBeTruthy()
    expect(@ability.can 'read', 6).toBeFalsy()


  it "should not pass class with object if 'all' objects are accepted", ->
    @ability.can 'preview', 'all', (object) ->
      object.should == 123
      @closureCalled = true

    expect(@ability.can 'preview', 123).toBeTruthy()
    expect(@closureCalled).toBeTruthy()


  it "should not call closure when only class is passed, only return true", ->
    @closureCalled = false
    @ability.can 'preview', 'all', (object) ->
      @closureCalled = true
    
    expect(@ability.can 'preview', Object).toBeTruthy()
    expect(@closureCalled).toBeFalsy()


  it "should pass only object for global manage actions", ->
    @ability.can 'manage', String, (object) ->
      	object.should == "foo"
      	@closureCalled = true
    
    expect(@ability.can 'stuff', "foo").toBeTruthy()
    expect(@closureCalled).toBeTruthy()


  it "should alias update or destroy actions to modify action", ->
    @ability.alias_action 'update', 'destroy', to: 'modify'
    @ability.can 'modify', 'all'
    
    expect(@ability.can 'update', 123).toBeTruthy()
    expect(@ability.can 'destroy', 123).toBeTruthy()