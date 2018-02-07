# Effective Website

This is a rails starter website that uses most of the effective_* gems.

Ruby 2.5.0. Rails 5.1.4

## Getting Started

- Clone this repo (or use suggested git workflow below).

- Create a config/database.yml.
- Create a ~/.env

- `bundle`
- `bundle exec rake db:create db:migrate db:seed`
- `rails server`

- Search the entire project for 'example' and fill in your site specifics.

- Good luck!

## Suggested git workflow

When starting a new site, create a new empty git repo, `origin`.  Then add `effective_website` as a second remote.

Pull the initial code, one time, from `effective_website/master` and from there on, push all changes to `origin/master` or develop.

Do not push to `effective_website/master`.

```
mkdir new_website
cd new_website
git init .
git remote add origin git@github.com:username/my_empty_repo.git
git remote add effective_website git@github.com:code-and-effect/effective_website.git
git pull effective_website master
git push origin master
```

Push all changes to `origin master`.

This workflow provides the normal `origin/master`, while maintaining the ability to pull in changes from `effective_website/master` if ever desired.

## License

MIT License.  Copyright [Code and Effect Inc.](http://www.codeandeffect.com/)

## Testing

```ruby
rake test
rake test:bot
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request

