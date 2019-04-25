# Effective Website

This is a rails starter website that uses most of the effective_* gems.

Ruby 2.5.0. Rails 5.2

## Getting Started

```ruby
git clone git@github.com:code-and-effect/effective_website.git
cd effective_website
bundle
rails db:create db:migrate db:seed
rails server
```

Login as `admin@codeandeffect.com` with any password.

- Search the entire project for 'example' and fill in your site specifics.

- Good luck!

## CORS Configuration

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Authorization</AllowedHeader>
</CORSRule>
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

## License

MIT License. Copyright [Code and Effect Inc.](https://www.codeandeffect.com/)

## Testing

```ruby
rails test
rails test:system
rails test:bot:environment
rails test:bot

rails test:system TOUR=true
rails test:bot TEST=admin/clients#index
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request

