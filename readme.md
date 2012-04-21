# Beer Can

A Tower extension that provides Authorization similar to CanCan that we have come to love in the Rails world.

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

if adminUser.can('manage').anyOfThe(@posts)

# apply extra condition if rule is true
if adminUser.can('manage').anyOfThe(@posts).byAny('author', boss)
```

This sort of functionality can implemented by adding functionality to the Boolean objects (or derivatives thereof?).

```coffeescript
CanDo extends Boolean
CanDo.prototype.byAny = -> (models)
  # ...

anyOfThe -> (models)
  return new CanDo(true)
```

```coffeescript
MyApp.Ability extends Tower.BeerCan.Ability
  initialize -> (subject, options = {})
    subject.can('read').any(Post).by('author', subject.boss)

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

* by(method_path) - object related to subject via method_path
* by(method_path, other) - object related to other via method_path
* by(method_path, other_fun) - object related to other via method_path
* by(pathFun, other_fun) - object related to other via path

* byAny(method_path) - subject part of objects via method_path
* byAny(method_path, other) - other is part of method_path collection
* byAny(method_path, other_fun) - other is part of method_path collection
* byAny(pathFun, other_fun) - other is part of path collection

