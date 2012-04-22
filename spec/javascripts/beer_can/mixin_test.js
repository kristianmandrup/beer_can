(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  describe('BeerCan.Mixin', function() {
    return beforeEach(function() {
      this.mixer = {};
      return __extends(this.mixer, BeerCan.Mixin);
    });
  });

}).call(this);
