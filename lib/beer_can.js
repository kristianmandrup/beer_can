(function() {
  var BeerCan,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  console.log('Drinking a Beer Can :)');

  Array.prototype.remove = function(e) {
    var t;
    if ((t = this.indexOf(e)) > -1) return this.splice(t, 1)[0];
  };

  BeerCan = {};

  require('./beer_can/rule');

  require('./beer_can/ability');

  require('./beer_can/api');

  require('./beer_can/mixin');

  require('./beer_can/model_mixin');

  if (typeof Tower !== "undefined" && Tower !== null) require('./beer_can/tower');

  BeerCan.RuleResult = (function(_super) {

    __extends(RuleResult, _super);

    function RuleResult() {
      RuleResult.__super__.constructor.apply(this, arguments);
    }

    RuleResult.prototype.byThe = function(relation) {};

    RuleResult.prototype.byAny = function(models) {};

    return RuleResult;

  })(Boolean);

  module.exports = BeerCan;

}).call(this);
