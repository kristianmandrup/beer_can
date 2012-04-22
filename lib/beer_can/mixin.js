(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  BeerCan.Mixin = (function(_super) {

    __extends(Mixin, _super);

    function Mixin() {
      Mixin.__super__.constructor.apply(this, arguments);
    }

    Mixin.prototype.currentAbility = function() {
      return this.currentAbility = BeerCan.Ability["new"](defaultCanSubject);
    };

    Mixin.prototype.defaultCanSubject = function() {
      return currentUser;
    };

    return Mixin;

  })(BeerCan.Api);

}).call(this);
