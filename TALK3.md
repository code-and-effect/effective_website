



Building Rails Engines

Matt Riemer
Code & Effect
Tadum.app

https://mattriemer.ca/
https://codeandeffect.com/
https://tadum.app/
https://github.com/code-and-effect/





















# Today

We are going to explore building a rails engine.



# What the heck is a rails engine?

A rails engine is a gem that runs within your main rails app.

Inside that gem can be models, controllers, views, database migrations, anything.

It's a mini rails app, inside your rails app.

A Rails application is actually just a "supercharged" engine,
with the Rails::Application class inheriting a lot of its behavior from Rails::Engine

Examples: devise, spree, refinery CMS


# Why would I use one?

If you run a whole bunch of rails sites, you quickly realize you're reinventing the wheel, writing the same screens over and over.

If you want to write that code just once, and reuse it anywhere, rails engines are the best way to do that.

Don't repeat yourself.

Don't repeat yourself.


# The rails engine go-to guide

A well written official guide is available.

https://guides.rubyonrails.org/engines.html

You can totally follow this and build a rails engine blog and learn all the best practices.

But, I'm going to totally ignore those, and today we will build our own thing.




# Let's go already

So I want to build a small but non-trivial rails engine in like 10 or 15 minutes.

We are going to build a 1-page rails engine that displays the valid? status of any persisted models in the database.

This could help us identify any invalid records in the database.

We will create:

- A rails engine
- A controller with just one action
- A route and view
- A custom stylesheet
- An ActiveRecord concern
- That's a lot already


# Effective Website

http://localhost:3000

So this is my rails starter website. I use this as a starting point whenever I build a new app.


# Create a new rails engine

> rails plugin new validator --full

*Add validator/ directory to VSCode*

Let's check out the structure.

It looks pretty close to a rails app.


# Gemspec

So without going into it too much, a rails engine is a gem.

As with any gem, the .gemspec file describes the package, its dependencies, and all the meta info.

Before we can even use it, we have to remove these TODO and FIXME commands from the


# Bundle it

In Gemfile:

gem 'validator', path: '~/Sites/validator'

> bundle install

That's all we gotta do to add the engine to our rails app.



# Hello Engine

So, everything we code here is going to be contained inside the rails engine.

Let's create a controller:

app/controllers/validator/validations_controller.rb

module Validator
  class ValidationsController < ApplicationController
    protect_from_forgery with: :exception

    layout 'application'

    def index
    end

  end
end


And a route in config/routes.rb:

Validator::Engine.routes.draw do
  scope module: 'validator' do
    match '/validations', to: 'validations#index', via: :get
  end
end


And create a view:

Create validator/validations/index.html.erb:

<h1>Hello Engine</h1>

<div id="validations">
  <p>This view is being served from the validator engine</p>
</div>

And one gotcha, we need to give this engine a name, so rails knows whats up with it:

lib/validator/engine.rb:

engine_name 'validator'

# Mount the engine in our rails app

config/routes.rb:

mount Validator::Engine => '/', :as => 'validator'

You could also mount it to another directory

This will show up in rake routes now


Add it to our navbar:

app/views/layouts/_navbar.html.haml:

= nav_link_to 'Validator Index', validator.validations_path


# Let's see it in action

> bundle exec rails server

visit

http://localhost:3000/validations

I sure hope we have a working page here!


# Let's add a quick stylesheet

So the page looks ugly, and we're not going to improve on that.

But we can add a stylesheet for a designer to come save us later.

Let's create app/assets/stylesheets/validator.css

#validations { background: #eee; }

And add it to our app stylesheet

@import 'validator';


# Let's add a module variable

Okay, this page looks pretty ugly.

Really, I just want to be able to use bootstrap, or tailwind, or something like that.

I need a way for the parent app to tell my engine view which html classes to use.

Let's create a module/engine top level variable to do that.

In validator.rb:

mattr_accessor :html_classes

def self.setup
  yield self
end

Make a default config file:

config/validator.rb

Validator.setup do |config|
  config.html_classes = ''
end

So my pattern is to put the default file in this here config/ directory.

# Let's make a rails generator

And then a rails generator to install that into the parent app's config/initializers/ directory

lib/generators/validator/install_generator.rb

module Validator
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Creates a Validator initializer in your application.'

      source_root File.expand_path(__FILE__)

      def copy_initializer
        template ('../' * 4) + 'config/validator.rb', 'config/initializers/validator.rb'
      end

    end
  end
end

# And install that into our main rails app

> rails generate validator:install

Generates the initializer file which gets run whenever our app starts.

Let's check it out, and add some default classes.

In config/initializers/validator.rb

config.html_classes = 'card card-body'

> bundle exec rails server

# Use this new config variable in our view

And back in our rails engine, let's reference this module variable:

index.html.erb

<h1>Hello Engine</h1>

<div id="validations" class="<%= Validator.html_classes %>">
  <p>This view is being served from the validator engine</p>
</div>

So now our parent app can tell our engine to render the div with its own classes


# Okay now let's build the validation part

Okay cool, so now we are going to add some common functionality to our models

We're going to do this through an ActiveRecord concern.

This is a piece of code that can be added onto any model.

app/models/concerns/acts_as_validation_source.rb

module ActsAsValidationSource
  extend ActiveSupport::Concern

  mattr_accessor :descendants

  module ActiveRecord
    def acts_as_validation_source(*options)
      include ::ActsAsValidationSource

      (ActsAsValidationSource.descendants ||= []) << self
    end
  end

  def is_valid?
    valid?
  end

end

And we need to register this concern with ActiveRecord

Add to engine.rb:

# Include acts_as_addressable concern and allow any ActiveRecord model to call it
initializer 'validator.active_record' do |app|
  ActiveSupport.on_load :active_record do
    ActiveRecord::Base.extend(ActsAsValidationSource::ActiveRecord)
  end
end

And restart our server one last time

> bundle exec rails server


Then we can add the common functionality onto any ActiveRecord model

In user.rb:

acts_as_validation_source

In client.rb:

acts_as_validation_source

On rails console, we can now call User.first.is_valid?


Update the view:

<h1>Hello Engine</h1>

<div id="validations" class="<%= Validator.html_classes %>">
  <% ActsAsValidationSource.descendants.each do |klass| %>
    <h2><%= klass.name.pluralize %></h2>

    <table class="table">
      <thead>
        <tr>
          <th>Aye Dee</th>
          <th>Name</th>
          <th>is_valid?</th>
          <th></th>
        </tr>
      </thead>

      <tbody>
        <% klass.all.find_each do |resource| %>
          <tr>
            <td><%= resource.id %></td>
            <td><%= resource %></td>
            <td><%= resource.is_valid? %></td>
            <td><%= resource.errors.full_messages.presence %></td>
          </tr>
        <% end %>
      </tbody>
    </table>

  <% end %>
</div>


Now what happens with an invalid model?

In user.rb:

validate do
  errors.add(:base, 'no fizz allowed') if id % 3 == 0
  errors.add(:base, 'no buzz allowed') if id % 5 == 0
end


# In Summary

We've just finished a whirlwind tour of building a rails engine.

We built:

- A rails engine
- A controller with just one action
- A route and view
- A custom stylesheet
- An ActiveRecord concern

Now we're ready to publish this gem to rubygems.com for the world to use!

Thanks for your time.

Gimme applause.

What questions do you have for me?
