# Beer Can

A Tower extension that provides Authorization similar to CanCan that we have come to love in the Rails world.

## Development

The tests use Jasmine. a Guardfile is included to ensure coffeescript files are watched and converted to javascript files that can be executed with Jasmine.
See http://watirmelon.com/2012/01/23/writing-a-coffeescript-web-application-using-tdd/

`guard init coffeescript`

`gem install jasmine guard-coffeescript`

`jasmine init`

Modify Jasmine configuration...

There’s a rake task called ‘jasmine’ which you can run to launch a jasmine server locally on port 8888. Then go to that pahe `http://localhost:8888` to see the results of the test.

## Current status

The initial version does away with the conditions hash and anything related to SQL queries. Also there is no support for resources and other extra features.

BeerCan initially focuses on delivering core Authorization functionality and then aims to expand the API, DSL and flexibility of use, before adding such extra features.

## Future goals

Beer Can aims to have a more "fluent" DSL and will be designed to be more flexible. It should be easy to authorize on any subject, not just `current_user` which is the case for CanCan.

Beer Can DSL examples:

```
if currentUser.can('read').any(Post)

if currentUser.can('read').the(@post)

if currentUser.can('read').allThe(@posts)

if adminUser.can('read', 'write').anyOfThe(@posts)

render :partial => 'posts' if adminUser.can('manage').anyOfThe(@posts)

# apply extra condition if rule is true
if adminUser.can('manage').anyOfThe(@posts).byAny('author', boss)
```

In the API shown, the `can` call would return a `BeerCan.ActionRule` which is populated with the actions that can be performed. Alternatively, the classic CanCan API can be used (although less powerful and flexible).

```coffeescript
if adminUser.can('manage', posts)
```

For the above API to work in a view or controller, the model in question must be decorated with appropriate context in order to authorize with that context in mind.

Imagine a before filter in a controller:

```coffeescript
currentUser.cans(@)
```

Now that user object would have access to the request and params object etc, have a `can` and `cannot` method added, which both create an Ability wrapping itself, and with the context passed into `cans`. See Ability constructor.

We could also have a `defaultCanSubject` which by default is `currentUser`

```coffeescript
Tower.Authorization.BeerCan
  defaultCanSubject -> 
    currentUser
```


This advanced DSL above can be implemented by adding functionality to the Boolean objects (I think). Then instead of returning simple boolean return a CanDo instance that extends Boolean with additional DSL functions.

```coffeescript
CanDo extends Boolean
CanDo.prototype.byAny = -> (models)
  # ...

anyOfThe -> (models)
  return new BeerCan.RuleResult(true)
```

```coffeescript
MyApp.Ability extends Tower.BeerCan.Ability
  initialize -> (subject, options = {})
    subject.can('read').any(Post).byThe('author', subject.boss)

    subject.can('read').any(Post).byAny('author', subject.bosses)

    # when subject is the post.author
    subject.can('manage').any(Post).when('author')

    # when subject.boss is the post.author
    subject.can('manage').any(Post).when(obj:'author', subj: 'boss')

    # when subject.boss.superior is the post.author
    subject.can('manage').any(Post).when(obj:'author', subj: 'boss.superior')

    # can manage any article by an author who is a particular kind of boss
    # a boss with certain attributes (bossSpecialAuthor)
    subject.can('manage').any(Article).when
      -> (subject, objects, options) {
        objects.first.authors.matches(subject.bosses.filterOn(options))

    subject.can('manage').any(Article).when('bossSpecialAuthor')
```    

```coffeescript
# Reusable auth mixins for special conditions
BeerCan.SpecialRelationships = {
  bossAuthor: -> (subject, objects, options))
    objects.first.authors.matches(subject.bosses.filterOn(options))
}
```

* any - Classes
* the - object
* all_the - collection, auth rule must be true for all
* any_of_the - collection, auth rule true for any

Complex conditions 

* byThe(method_path) - object related to subject via method_path
* byThe(method_path, other) - object related to other via method_path
* byThe(method_path, other_fun) - object related to other via method_path
* byThe(pathFun, other_fun) - object related to other via path

* byAny(method_path) - subject part of objects via method_path
* byAny(method_path, other) - other is part of method_path collection
* byAny(method_path, other_fun) - other is part of method_path collection
* byAny(pathFun, other_fun) - other is part of path collection

## Running tests jasmine ruby

Run

`bundle`

To install the ruby gems

See [Jasmine - headless](http://johnbintz.github.com/jasmine-headless-webkit/)

Then run

`jasmine-headless-webkit`

## Running tests jasmine node

Install jasmine-node

`npm install jasmine-node -g

Run

`jasmine-node --color spec`

## Running tests with mocha

Install mocha

`npm install mocha -g

Run

`npm test`


## Notes on Node modules
* [Cakefile template](https://github.com/twilson63/cakefile-template/blob/master/Cakefile)
* [Piece of Cakefile](http://k20e.com/blog/2011/05/02/a-piece-of-cakefile/)
* [Coffee build tools](https://github.com/jashkenas/coffee-script/wiki/%5BHowTo%5D-Compiling-and-Setting-Up-Build-Tools)
* [Modules and npm](http://book.mixu.net/ch8.html)
* [How to module](http://howtonode.org/how-to-module)
* [Publishing Node modules](http://www.unrealcreations.com/groups/jahovaos/wiki/34d86/Writing_and_Publishing_nodejs_Modules.html)
