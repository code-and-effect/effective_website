# Effective Website

This is a rails starter website that uses most of the effective_* gems.

Ruby 2.7.1 Rails 6.1

## Live Demo

Click here for a [Live Demo](https://effective-website-demo.herokuapp.com/).

Login as `admin@codeandeffect.com` with password `example`.

## Getting Started

```ruby
git clone git@github.com:code-and-effect/effective_website.git

cd effective_website
cp .env.example .env  # Fixes SECRET_KEY_BASE errors

bundle install
yarn install

rails db:create db:migrate db:seed
rails server
```

Login as `admin@codeandeffect.com` with any password.

- Search the entire project for 'example' and fill in your site specifics.
- Good luck!

Run tests with

```ruby
rails test
rails test:system

rails test:bot:environment
rails test:bot:system
```

## Docker

You can also use Docker to install and run this site:

```
cp config/database.yml.docker config/database.yml
docker-compose build

# One time
docker-compose run web bash
rake db:create db:migrate db:seed
exit

# And then, each time
docker-compose run web
```

## Heroku

When deploying to heroku, we need to use two build packs.

To configure heroku, run the following (one time only):

```
heroku buildpacks:add --index 1 heroku/nodejs
heroku buildpacks:add --index 2 heroku/ruby
```

## Amazon S3

If you want to use Amazon S3 for ActiveStorage

Uncomment `amazon` in `config/storage.yml` and add ENV variables.

Change `config.active_storage.service` to `:amazon` in one or more `config/environments/` files.

### Log into AWS Console

- Visit http://aws.amazon.com/console/
- Click 'Sign In to the Console' from the top-right and sign in with your AWS account.

### Create an S3 Bucket

- Click Services -> S3 from the top-left menu
- Click Create Bucket
- Give the Bucket a name, and select the US East (N. Virgina) region.
- Click Next, Next, Next
- Don't configure permissions yet, we still have to create a user
- Click Next

### Configure CORS Permissions

- From the S3 All Buckets Screen (as above)

- Click the S3 bucket we just created
- Click the Permissions tab
- Click CORS configuration and enter the following:

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

- Click Save

The Bucket is now set up and ready to accept uploads, but we still need a user that has permission to access S3

### Create an IAM User and record its AWS Access Keys

- After logging in to your AWS console

- Click Services -> IAM from the top-left

- Select Users from the left-side menu
- Click Add user
- Give it a user name
- Check Yes Programmatic access, No AWS management console access

- Click Next: Permissions
- Click Create group
- Give it a name like 's3-full-access'
- Scroll down and select 'AmazonS3FullAccess'
- Click Create group
- Click Next: Review
- Click Create user
- Record the Access key ID and Secret access key.

Copy these values into your `.env` file.

This user is now set up and ready to access the S3 Bucket previously created.

## Omniauth

We support omniauth oauth2 authentication via Google, Facebook, Microsoft and other omniauth providers.

https://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/

### Facebook oAuth2

- Add `gem 'omniauth-facebook'` to Gemfile and bundle.

- Visit https://developers.facebook.com

- Login and click My Apps

- Click 'Create App'
  - Manage Business Integrations
  - App Purpose Yourself or your own business

- Click 'Settings' and 'Basic'
  - App Domains: https://example.herokuapp.com

- Scroll down to the bottom and click "+ Add Platform" -> Web
  - Site URL: https://example.herokuapp.com

- Copy the App ID and App secret into the `.env` file and/or set server production ENV variables

- Click 'Facebook Login' and 'Settings'
  - Client OAuth Login: Yes
  - Web OAuth Login: Yes
  - Valid OAuth Redirect URIs: https://example.herokuapp.com/users/auth/facebook/callback

- Click the 'In development / Live' radio button from the top. Switch to Live.

```
FACEBOOK_APP_ID=
FACEBOOK_SECRET=
```

### Google oAuth2

- Add `gem 'omniauth-google-oauth2'` to Gemfile and bundle.

- Visit https://console.developers.google.com

- Click 'New Project' and give it a name
- Open 'APIs' 'Library' section and make sure Google+ API is enabled

- Click 'OAuth consent screen' and create the oAuth application
  - External
  - Fill in Application Name

- Click the 'Credentials' side bar item
  - Click Create Credentials -> OAuth client ID

  - Authorized JavaScript origins
    - URIs: https://example.herokuapp.com

  - Authorized redirect URIs:
    - URIs: https://example.herokuapp.com/users/auth/google_oauth2/callback

  - Copy the Client ID and Client secret into the `.env` file and/or set server production ENV variables

```
GOOGLE_CLIENT_ID=
GOOGLE_SECRET=
```

### Microsoft oAuth2

- Add `gem 'omniauth-microsoft_graph'` to Gemfile and bundle.

- Visit https://aad.portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview

- Find Azure Active Directory
- Click 'App registrations' from left menu

- Click 'New Registration'
  - Supported account types: Accounts in any organizational directory (Any Azure AD directory - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)
  - Redirect URI: Web https://example.herokuapp.com/users/auth/microsoft_graph/callback

  - Copy the Application (client) ID into the `.env` file and/or set server production ENV variables

- Click 'Certificates & Secrets'
  - Click 'New client secret'
  - Copy the Client secret into the `.env` file and/or set server production ENV variables

```
MICROSOFT_APP_ID=
MICROSOFT_SECRET=
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
