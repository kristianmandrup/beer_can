(function() {
  var __slice = Array.prototype.slice;

  BeerCan.Api = (function() {

    function Api() {}

    Api.prototype.can = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return currentAbility.can.apply(currentAbility, args);
    };

    Api.prototype.cannot = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return currentAbility.cannot.apply(currentAbility, args);
    };

    return Api;

  })();

}).call(this);
