(function() {

  describe('BeerCan.Rule', function() {
    beforeEach(function() {
      return this.rule = new BeerCan.Rule(true, 'read', Integer);
    });
    return it("should ...", function() {
      return expect(this.rule).toBeTrusy();
    });
  });

}).call(this);
