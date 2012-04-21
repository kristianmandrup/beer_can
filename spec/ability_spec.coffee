# TODO

describe 'BeerCan.Ability' do
	# before each
  @ability = {}
  @ability.extends BeerCan.Ability

  it "should be able to 'read' anything"
    @ability.can 'read', 'all'

    @ability.can('read', String).should be_true
    @ability.can('read', 123).should be_true
  end

  it "should not have permission to do something it doesn't know about"
    @ability.can('foodfight', String).should be_false


  it "should pass true to `can` when non false/nil is returned in closure"
    @ability.can 'read', 'all'
    @ability.can 'read', String, 
    	# TODO test that sym is nil when no instance is passed
    	-> (sym) 
      	"foo" 
    @ability.can('read', 'some_string').should be_true


  it "should pass nil to a closure when no instance is passed"
    @ability.can 'read', String
    	-> (sym) 
      	sym.should be_nil
      	true
    @ability.can('read', String).should be_true


  it "should pass to previous rule, if closure returns false or nil"
    @ability.can 'read', String
    @ability.can 'read', Integer
    	-> (i)
      	i < 5
    @ability.can 'read', Integer
    	-> (i)
      	i > 10
    @ability.can('read', String).should be_true
    @ability.can('read', 11).should be_true
    @ability.can('read', 1).should be_true
    @ability.can('read', 6).should be_false


  it "should not pass class with object if 'all' objects are accepted"
    @ability.can 'preview', 'all'
    	-> (object)
      	object.should == 123
      	@closureCalled = true
    @ability.can('preview', 123)
    @closureCalled.should be_true


  it "should not call closure when only class is passed, only return true"
    @closureCalled = false
    @ability.can 'preview', 'all'
    	-> (object)
      @closureCalled = true
    @ability.can('preview', Object).should be_true
    @closureCalled.should be_false


  it "should pass only object for global manage actions"
    @ability.can 'manage', String
    	-> (object)
      	object.should == "foo"
      	@closureCalled = true
    @ability.can('stuff', "foo").should
    @closureCalled.should be_true


  it "should alias update or destroy actions to modify action"
    @ability.alias_action 'update', 'destroy', to: 'modify'
    @ability.can 'modify', 'all'
    @ability.can('update', 123).should be_true
    @ability.can('destroy', 123).should be_true
