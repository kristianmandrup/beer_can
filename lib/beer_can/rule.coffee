Tower.Authorization.BeerCan.Rule extend Class
  # This class is used internally and should only be called through Ability.
  # it holds the information about a "can" call made on Ability and provides
  # helpful methods to determine permission checking and conditions hash generation.

    # attr_reader :base_behavior, :subjects, :actions, :conditions
    # attr_writer :expanded_actions

    # The first argument when initializing is the base_behavior which is a true/false
    # value. True for "can" and false for "cannot". The next two arguments are the action
    # and subject respectively (such as :read, @project). The third argument is a hash
    # of conditions and the last one is the block passed to the "can" call.
  initialize -> (baseBehavior, action, subject, closure)
    if closure && !_.isFunction(closure)
      throw new Error("The last argument must be a closure, was: #{closure}") 
    @matchAll = (action =! null && subject != null)
    @baseBehavior = baseBehavior
    @actions      = _.flatten action
    @subjects     = _.flatten subject
    @conditions   = conditions || {}
    @closure      = closure

    # Matches both the subject and action
  relevant -> (action, subject)
      @match_all || (matchesAction(action) && matchesSubject(subject))

    # Matches the block or conditions hash
  matchesConditions -> (action, subject, args)
      if @matchAll
        callClosureWithAll(action, subject, args)
      else if @closure && !subjectClass(subject)
        @closure(subject, args)
      else
        true

  subjectClass -> (subject)
    _.isClass(subject) ? subject : subject.class

  matchesAction -> (action)
    @expandedActions.indexOf('manage') || @expandedActions.indexOf('action')

  matchesSubject -> (subject)
    @subjects.indexOf('all') || @subjects.indexOf(subject) || matchesSubjectClass(subject)

  # TODO: Fix!
  matchesSubjectClass -> (subject)
    @subjects.matchesAny -> (sub)
      if sub.prototype.prototype != sub.prototype
        matchesAny(prototype)
      else
        subject.prototype == sub # test prototype hierarchy

  callClosureWithAll -> (action, subject, args)
      if _.isClass(subject.class)
        @closure action, subject, nil, args
      else
        @closure action, subject.class, subject, args

