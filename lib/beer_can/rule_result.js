(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  BeerCan.RuleResult = (function(_super) {

    __extends(RuleResult, _super);

    RuleResult.name = 'RuleResult';

    function RuleResult() {
      return RuleResult.__super__.constructor.apply(this, arguments);
    }

    RuleResult.prototype.byThe = function(relation) {};

    RuleResult.prototype.byAny = function(models) {};

    return RuleResult;

  })(Boolean);

}).call(this);
