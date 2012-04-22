(function() {

  BeerCan.ModelMixin = (function() {

    function ModelMixin() {}

    ModelMixin.prototype.accessibleBy = function(ability, action) {
      if (action == null) action = 'index';
      return ability.execute(self, action);
    };

    return ModelMixin;

  })();

  ({
    cans: function(context) {
      this.authContext = context;
      return this(extend(BeerCan.Api));
    }
  });

}).call(this);
