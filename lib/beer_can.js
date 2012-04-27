(function() {
  var BeerCan;

  console.log('Drinking a Beer Can :)');

  Array.prototype.remove = function(e) {
    var t;
    if ((t = this.indexOf(e)) > -1) {
      return this.splice(t, 1)[0];
    }
  };

  module.exports = global.BeerCan = BeerCan = {};

  require('./beer_can/rule');

  require('./beer_can/ability');

  require('./beer_can/api');

  require('./beer_can/mixin');

  require('./beer_can/model_mixin');

  if (typeof Tower !== "undefined" && Tower !== null) {
    require('./beer_can/tower');
  }

  console.log('Exported BeerCan module as global');

}).call(this);
