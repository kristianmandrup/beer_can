(function() {

  describe('BeerCan.Controller', function() {
    return beforeEach(function() {
      this.controller = new Tower.Authorization.BeerCan.Controller;
      it("should have a current_ability method which generates an ability for the current user", function() {
        return expect(this.controller.currentAbility).prototype.toEqual(Ability);
      });
      return it("should provide a can? and cannot? methods which go through the current ability", function() {
        expect(this.controller.currentAbility).prototype.toEqual(Ability);
        expect(this.controller.can('foo', 'bar')).toBeFalsy();
        return expect(this.controller.cannot('foo', 'bar')).toBeTrusy();
      });
    });
  });

}).call(this);
