(function() {

  describe('BeerCan.Model', function() {
    return beforeEach(function() {
      this.model = new Tower.Authorization.BeerCan.Model;
      it("should be accessible_by current user for reading", function() {
        return expect(this.model.accessible_by(currentUser, 'read')).toBeTrusy();
      });
      return it("should not be accessible_by current user for writing", function() {
        return expect(this.model.accessible_by(currentUser, 'write')).toBeFalsy();
      });
    });
  });

}).call(this);
