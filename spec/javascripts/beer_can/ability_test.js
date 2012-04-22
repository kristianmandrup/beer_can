(function() {

  describe('Tower.Authorization.BeerCan.Ability', function() {
    beforeEach(function() {
      this.ability = {};
      return this.ability["extends"](BeerCan.Ability);
    });
    it("should be able to 'read' anything", function() {
      this.ability.can('read', 'all');
      expect(this.ability.can('read', String)).toBeTruthy();
      return expect(this.ability.can('read', 123)).toBeTruthy();
    });
    it("should not have permission to do something it doesn't know about", function() {
      return expect(this.ability.can('foodfight', String)).toBeFalsy();
    });
    it("should pass true to `can` when non false/nil is returned in closure", function() {
      this.ability.can('read', 'all');
      this.ability.can('read', String, function(sym) {
        return "foo";
      });
      return expect(this.ability.can('read', 'some_string')).toBeTruthy();
    });
    it("should pass nil to a closure when no instance is passed", function() {
      this.ability.can('read', String, function(sym) {
        sym.should(be_nil);
        return true;
      });
      return expect(this.ability.can('read', String)).toBeTruthy();
    });
    it("should pass to previous rule, if closure returns false or nil", function() {
      this.ability.can('read', String);
      this.ability.can('read', Integer, function(i) {
        return i < 5;
      });
      this.ability.can('read', Integer, function(i) {
        return i > 10;
      });
      expect(this.ability.can('read', String)).toBeTruthy();
      expect(this.ability.can('read', 11)).toBeTruthy();
      expect(this.ability.can('read', 1)).toBeTruthy();
      return expect(this.ability.can('read', 6)).toBeFalsy();
    });
    it("should not pass class with object if 'all' objects are accepted", function() {
      this.ability.can('preview', 'all', function(object) {
        object.should === 123;
        return this.closureCalled = true;
      });
      expect(this.ability.can('preview', 123)).toBeTruthy();
      return expect(this.closureCalled).toBeTruthy();
    });
    it("should not call closure when only class is passed, only return true", function() {
      this.closureCalled = false;
      this.ability.can('preview', 'all', function(object) {
        return this.closureCalled = true;
      });
      expect(this.ability.can('preview', Object)).toBeTruthy();
      return expect(this.closureCalled).toBeFalsy();
    });
    it("should pass only object for global manage actions", function() {
      this.ability.can('manage', String, function(object) {
        object.should === "foo";
        return this.closureCalled = true;
      });
      expect(this.ability.can('stuff', "foo")).toBeTruthy();
      return expect(this.closureCalled).toBeTruthy();
    });
    return it("should alias update or destroy actions to modify action", function() {
      this.ability.alias_action('update', 'destroy', {
        to: 'modify'
      });
      this.ability.can('modify', 'all');
      expect(this.ability.can('update', 123)).toBeTruthy();
      return expect(this.ability.can('destroy', 123)).toBeTruthy();
    });
  });

}).call(this);
