Matt Riemer
Code & Effect
https://github.com/code-and-effect/effective_website


https://guides.rubyonrails.org/engines.html

Today we are going to talk about rails engines.

# What the heck is a rails engine?

A rails engine is a miniature application that you can host within your rails app.

It's a mini rails app, inside your rails app.

# Why would I use one?

So if you want to use the same functionality in more than one app, this is the best way
to bring all your code with you.

# Let's jump into building

So I want to build a 1-page rails engine that considers all the models in the parent rails app.

IT's going to run validate on all of the records, and display TRUE|FALSE if the record is valid

I want to show off a engine controller

A rails ActiveRecord concern

And just a bit more

# Code

> rails plugin new validator --mountable

Let's check out the structure.

It looks pretty close to a rails app.

It doesn't do anything yet.

So let's just add a route, and a page, so we have something to look at.


We have to update the gemspec, and remove any TODO or FIXME


Let's add a controller:

app/controllers/validator/validations_controller.rb

module Validator
  class ValidationsController < ApplicationController
    protect_from_forgery with: :exception

    skip_authorization_check

    def index
    end

  end
end

And a route:

Validator::Engine.routes.draw do
  scope module: 'validator' do
    match '/validator', to: 'validations#index', via: :get, as: 'validator'
  end
end

And a view:

validator/validations/index.html.haml

%h1 Hey there

#validations
  %p You found the validator

Okay, so believe me, this rails engine is gonna kind of do something now.

Let's hook it up to our main rails app


# Install the engine

gem 'validator', path: '~/Sites/validator'

bundle install

Mount the engine in our routes.

mount Validator::Engine => '/', :as => 'validator

* You could also mount it into another directory

We can now see it in rake routes

bundle exec rails server

visit

http://localhost:3000/validator


Sure enough, we have a page here.

Looks ugly of course, let's add a stylesheet

app/assets/stylesheets/validator.css

#validations { background: lightgray; }


And add it to our app stylesheet

@import 'validator';


Okay, this looks pretty ugly, maybe we want to be able to add some css classes to this view

Let's create a config variable to do that.

In validator.rb:

mattr_accessor :html_classes

  def self.setup
    yield self
  end


Make a config file:

config/validator.rb

Validator.setup do |config|
  config.html_classes = 'card card-body'
end

So I like to put a default file in my config/ directory


And let's make a task to install this into the parent app

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

rails generate validator:install

We now have this config/validator.rb file that gets run whenever our app starts


So now let's use this config variable we just made

index.html.haml

#validations{class: Validator.html_classes}



Okay, cool, so now we're going to create an ActiveRecord concern
That we can add to any model, just to keep track of it


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

engine.rb

# Include acts_as_addressable concern and allow any ActiveRecord object to call it
initializer 'validator.active_record' do |app|
  ActiveSupport.on_load :active_record do
    ActiveRecord::Base.extend(ActsAsValidationSource::ActiveRecord)
  end
end

  -# Make sure all the classes are loaded (development mode fix)
  - Rails.application.eager_load!

  - ActsAsValidationSource.descendants.each do |klass|
    %h2= klass.name.pluralize

    %table.table
      %thead
        %tr
          %th Name
          %th is_valid?
          %th

      %tbody
        - klass.all.find_each do |resource|
          %tr
            %td= resource.to_s
            %td= resource.is_valid?
            %td= resource.errors.full_messages
