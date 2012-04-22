(function() {

  BeerCan.ActionRule = (function() {

    function ActionRule(actions) {
      initialize(actions);
    }

    ActionRule.prototype.initialize = function(actions) {
      this.actions = actions;
    };

    ActionRule.prototype.any = function(model_classes) {
      this.model_classes = model_classes;
      return new BeerCan.Rule(this);
    };

    ActionRule.prototype.the = function(model) {
      this.model = model;
      return new Rule(this);
    };

    ActionRule.prototype.all_the = function(models) {};

    ActionRule.prototype.any_of_the = function(models) {};

    return ActionRule;

  })();

}).call(this);
