(function() {
  var __slice = Array.prototype.slice,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  BeerCan.Ability = (function() {

    function Ability() {}

    Ability.prototype.can = function() {
      var action, args, match, subject;
      action = arguments[0], subject = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      match = relevantRulesForMatch(action, subject).detect(function(rule) {
        return rule.matchesConditions.apply(rule, [action, subject].concat(__slice.call(args)));
      });
      if (match) {
        return match.baseBehavior;
      } else {
        return false;
      }
    };

    Ability.prototype.cannot = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return !can.apply(null, args);
    };

    Ability.prototype.can = function(action, subject, closure) {
      return rules.concat(BeerCan.Rule["new"](true, action, subject, closure));
    };

    Ability.prototype.cannot = function(action, subject, closure) {
      return rules.concat(BeerCan.Rule["new"](false, action, subject, closure));
    };

    Ability.prototype.defaultAliasActions = function() {
      return {
        'read': ['index', 'show'],
        'create': ['new'],
        'update': ['edit']
      };
    };

    Ability.prototype.aliasedActions = function() {
      var _ref;
      return (_ref = this.aliasedActions) != null ? _ref : this.aliasedActions = defaultAliasActions;
    };

    Ability.prototype.aliasAction = function() {
      var args, target;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      target = args.remove('to');
      if (aliasedActions[target] == null) aliasedActions[target] = [];
      return aliasedActions[target] += args;
    };

    Ability.prototype.clearAliasedActions = function() {
      return this.aliasedActions = {};
    };

    Ability.prototype.aliasesForAction = function(action) {
      var results;
      results = _.flatten([action]);
      _.each(aliasedActions, function(aliasedAction, actions) {
        if (__indexOf.call(actions, action) >= 0) {
          return results += aliasesForAction(aliasedAction);
        }
      });
      return results;
    };

    Ability.prototype.rules = function() {
      var _ref;
      return (_ref = this.rules) != null ? _ref : this.rules = [];
    };

    Ability.prototype.relevantRules = function(action, subject) {
      return _.reverse(rules).select(function(rule) {
        rule.expandedActions = expandActions(rule.actions);
        return rule.relevant(action, subject);
      });
    };

    return Ability;

  })();

  module.exports = BeerCan.Ability;

}).call(this);
