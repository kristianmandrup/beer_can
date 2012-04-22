class BeerCan.Ability # extends Class
  # Not only can you use the can? method in the controller and view (see ControllerAdditions),
  # but you can also call it directly on an ability instance.
  #
  #   ability.can? :destroy, @project
  #
  # This makes testing a user's abilities very easy.
  #
  #   def test "user can only destroy projects which he owns"
  #     user = User.new
  #     ability = Ability.new(user)
  #     assert ability.can?(:destroy, Project.new(:user => user))
  #     assert ability.cannot?(:destroy, Project.new)
  #   end
  #
  # Also see the RSpec Matchers to aid in testing.
  can: (action, subject, args...) -> 
    match = relevantRulesForMatch(action, subject).detect (rule) ->
      rule.matchesConditions action, subject, args...
    if match then match.baseBehavior else false

  # Convenience method which works the same as "can?" but returns the opposite value.
  #
  #   cannot? :destroy, @project
  #
  cannot: (args...) ->
    !can args...


  # Defines which abilities are allowed using two arguments. The first one is the action
  # you're setting the permission for, the second one is the class of object you're setting it on.
  #
  #   can :update, Article
  #
  # You can pass an array for either of these parameters to match any one.
  # Here the user has the ability to update or destroy both articles and comments.
  #
  #   can [:update, :destroy], [Article, Comment]
  #
  # You can pass :all to match any object and :manage to match any action. Here are some examples.
  #
  #   can :manage, :all
  #   can :update, :all
  #   can :manage, Project
  #
  # You can pass a hash of conditions as the third argument. Here the user can only see active projects which he owns.
  #
  #   can :read, Project, :active => true, :user_id => user.id
  #
  # See ActiveRecordAdditions#accessible_by for how to use this in database queries. These conditions
  # are also used for initial attributes when building a record in ControllerAdditions#load_resource.
  #
  # If the conditions hash does not give you enough control over defining abilities, you can use a block
  # along with any Ruby code you want.
  #
  #   can :update, Project do |project|
  #     project.groups.include?(user.group)
  #   end
  #
  # If the block returns true then the user has that :update ability for that project, otherwise he
  # will be denied access. The downside to using a block is that it cannot be used to generate
  # conditions for database queries.
  #
  # You can pass custom objects into this "can" method, this is usually done with a symbol
  # and is useful if a class isn't available to define permissions on.
  #
  #   can :read, :stats
  #   can? :read, :stats # => true
  #
  # IMPORTANT: Neither a hash of conditions or a block will be used when checking permission on a class.
  #
  #   can :update, Project, :priority => 3
  #   can? :update, Project # => true
  #
  # If you pass no arguments to +can+, the action, class, and object will be passed to the block and the
  # block will always be executed. This allows you to override the full behavior if the permissions are
  # defined in an external source such as the database.
  #
  #   can do |action, object_class, object|
  #     # check the database and return true/false
  #   end
  #
  can: (action, subject, closure) ->
    rules.concat BeerCan.Rule.new(true, action, subject, closure)

  # Defines an ability which cannot be done. Accepts the same arguments as "can".
  #
  #   can :read, :all
  #   cannot :read, Comment
  #
  # A block can be passed just like "can", however if the logic is complex it is recommended
  # to use the "can" method.
  #
  #   cannot :read, Product do |product|
  #     product.invisible?
  #   end
  #
  cannot: (action, subject, closure) ->
    rules.concat BeerCan.Rule.new(false, action, subject, closure)

  defaultAliasActions: ->
    'read':   ['index', 'show']
    'create': ['new']
    'update': ['edit']

  # Returns a hash of aliased actions. The key is the target and the value is an array of actions aliasing the key.
  aliasedActions: ->
    @aliasedActions ?= defaultAliasActions

  # The following aliases are added by default for conveniently mapping common controller actions.
  #
  #   alias_action :index, :show, :to => :read
  #   alias_action :new, :to => :create
  #   alias_action :edit, :to => :update
  #
  # This way one can use params[:action] in the controller to determine the permission.
  aliasAction: (args...) ->
    target = args.remove 'to'
    aliasedActions[target] ?= []
    aliasedActions[target] += args


  # Removes previously aliased actions including the defaults.
  clearAliasedActions: ->
    @aliasedActions = {}


  # Given an action, it will try to find all of the actions which are aliased to it.
  # This does the opposite kind of lookup as expand_actions.
  aliasesForAction: (action) ->
    results = _.flatten [action]
    _.each aliasedActions, (aliasedAction, actions) ->
      results += aliasesForAction(aliasedAction) if action in actions
    results

  rules: -> 
    @rules ?= [] 

  # Returns an array of Rule instances which match the action and subject
  # This does not take into consideration any hash conditions or block statements
  relevantRules: (action, subject) ->
    _.reverse(rules).select (rule) ->
      rule.expandedActions = expandActions(rule.actions)
      rule.relevant(action, subject)
