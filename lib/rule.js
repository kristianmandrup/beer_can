(function() {
  var __slice = Array.prototype.slice,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  BeerCan.Rule = (function() {

    function Rule(baseBehavior, action, subject, closure) {
      this.initialize(baseBehavior, action, subject, closure);
    }

    Rule.prototype.initialize = function(baseBehavior, action, subject, closure) {
      var _ref;
      this.baseBehavior = baseBehavior;
      this.closure = closure;
      if (closure && !_.isFunction(closure)) {
        throw new Error("The last argument must be a closure, was: " + closure);
      }
      this.matchAll = (action != null) && (subject != null);
      return _ref = [_.flatten(action), _.flatten(subject)], this.actions = _ref[0], this.subjects = _ref[1], _ref;
    };

    Rule.prototype.relevant = function(action, subject) {
      return this.match_all || (matchesAction(action) && matchesSubject(subject));
    };

    Rule.prototype.matchesConditions = function() {
      var action, args, subject;
      action = arguments[0], subject = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      if (this.matchAll) {
        return callClosureWithAll.apply(null, [action, subject].concat(__slice.call(args)));
      } else if (this.closure && !subjectClass(subject)) {
        return this.closure(subject, args);
      } else {
        return true;
      }
    };

    Rule.prototype.subjectClass = function(subject) {
      var _ref;
      return (_ref = _.isClass(subject)) != null ? _ref : {
        subject: subject["class"]
      };
    };

    Rule.prototype.matchesAction = function(action) {
      return __indexOf.call(this.expandedActions, 'manage') >= 0 || __indexOf.call(this.expandedActions, action) >= 0;
    };

    Rule.prototype.matchesSubject = function(subject) {
      return __indexOf.call(this.subjects, 'all') >= 0 || __indexOf.call(this.subjects, subject) >= 0 || matchesSubjectClass(subject);
    };

    Rule.prototype.matchesSubjectClass = function(subject) {
      return this.subjects.matchesAny = function(sub) {
        return subject instanceof sub;
      };
    };

    Rule.prototype.callClosureWithAll = function() {
      var action, args, subject;
      action = arguments[0], subject = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      if (_.isClass(subject["class"])) {
        return this.closure.apply(this, [action, subject, nil].concat(__slice.call(args)));
      } else {
        return this.closure.apply(this, [action, subject["class"], subject].concat(__slice.call(args)));
      }
    };

    return Rule;

  })();

}).call(this);
