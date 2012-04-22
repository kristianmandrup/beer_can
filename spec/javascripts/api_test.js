(function() {

  require('../config');

  describe('BeerCan.Api', function() {
    return beforeEach(function() {
      this.ctx = {};
      return this.ctx(extend(BeerCan.Api));
    });
  });

}).call(this);
