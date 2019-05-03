# Effective Talk

## Slides

Oh shazbot, I forgot my slides. Wait, here they are.  *slides*

Matt Riemer
Code & Effect
https://github.com/code-and-effect/effective_website

Building Effective Websites
YEGRB Edmonton
https://yegrb.com


## Introduction

http://mattriemer.ca

My name is Matt Riemer, I'm a full time ruby on rails developer and open sourcerer.

I'm the co-founder and CTO of Code & Effect, the most effective web consultancy here in Edmonton.

https://codeandeffect.com/

One of our missions at Code & Effect is to contribute back to our community.

We do this in a lot of ways, and open source is one of those.

https://github.com/code-and-effect

Over the last 10 years, we've built and now maintain a whole bunch of client apps.

So we try to embrace the Rails Way. Write as little code as possible. Be simple rather than clever. Explicit over implicit.

Core to the rails way is CRUD and REST, and that's really the kind of apps I build.

A lot of database CRUD.

The effective gems make it super easy to build these kind of apps. And I want to show off what they can do :)

So today, we have about 30 minutes to get through the following 5 goals:

1.) A tour of my starter website app and effective gem stack.
2.) A deep dive into code and how to evaluate a rails app you're seeing for the first time.
3.) Learn my personal process behind building rails sites. We're going to build out an entire non-trivial feature.

and, of course, to entertain and delight your senses:

4.) I will provide you with at least 10 time saving tips that have nothing to do with the effective_* stack.
5.) And there will be skill testing questions throughout

## My Stack

So I am kind of an oldschool developer.

Sublime Text
Try to use rails console
Firefox4Life

## Exploring the App Code - Round 1

It takes too darn long to make a fresh rails website. Nevermind an effective one.

TIME SAVER #1: Maintain your own stater template site.

https://github.com/code-and-effect/effective_website

This is the same process I use when evaluating any new rails app.

- Gemfile
POP QUIZ #1:  Can anyone give me a 1 sentence quick description for all 12 of these gems?

- application.js
- application.scss

Skip over controllers and datatables for now.

Show data model.

- User has_many clients through mates

- User permissions
  - admin
  - staff
  - client

- Mate permissions
  - owner
  - member
  - collaborator


## Explore the App

https://localhost:3000

So, this is a fresh install of effective_website as per github with no other customizations made.

This is what I start with to begin a new client project.

You can see I am not a designer. It's Twitter Bootstrap 4 but pretty unstyled.

Function over fashion.

Run through the app. Log in as admin@codeandeffect.com / any password

TIME SAVER #2: Development mode any password

- Home page. These are editable regions, I'll show that off later

- Blog
https://github.com/code-and-effect/effective_posts

- Content Pages
https://github.com/code-and-effect/effective_pages

- Style Guide

- Admin Users
https://github.com/code-and-effect/effective_datatables

- Admin Clients
- Pages
- Posts
- Logs
- Orders

## Exploring the App Code - Round 2

POP QUIZ: When receiving a web request, what is the first file that rails runs?

- routes.rb
  - talk about resources

- Tests controller
TIME SAVER: Have a secret endpoint that you can can test your app

POP QUIZ: What are the 7 restful routes? or the 7 CRUD actions

https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions

- Member routes / collection routes

- ability.rb
  - action matches http and controller and route action

Controller
  - Admin::Clients#controller

https://github.com/code-and-effect/effective_resources


Views
-  Layouts

TIME SAVER: A good layout


Btw those `tabs do` and other helpers come from effective bootstrap gem.

https://github.com/code-and-effect/effective_bootstrap


Other views

POP QUIZ: What files do you NOT see in these directories

Application Templates

TIME SAVER #3: Application templates

## Effective Resources

A big part of my process is trying not to write code.

The best code is no code at all. So to that end, I wrote

https://github.com/code-and-effect/effective_resources

It uses routes.rb, ability.rb and current_user and the controller to just do the right thing.

TIME SAVER #3: Don't write code at all

## So let's go and build something

The very first thing I do is write a model file. I sit for 30 minutes and think hard.

Semantic satiation
A psychological phenomenon in which repetition causes a word or phrase to temporarily lose meaning for the listener, 
who then perceives the speech as repeated meaningless sounds.

https://en.wikipedia.org/wiki/Semantic_satiation

class Autopsy < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  CAUSES = ['Organ failure', 'Heart Attack', 'Brain Tumor']

  effective_resource do
    name          :string
    age           :integer
    date          :datetime

    cause         :string
    description   :text

    timestamps
  end

  scope :deep, -> { includes(:created_by) }
  scope :sorted, -> { order(:created_at) }

  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

  validates :cause, presence: true, inclusion: { in: CAUSES }
  validates :description, presence: true

  def to_s
    name || 'New Autopsy'
  end

end

Then I type this, and I'm done!

rails generate effective:scaffold autopsy

To the app!

## Scaffolds

TIME SAVER #3: Scaffolds

rails generate scaffold

https://guides.rubyonrails.org/v3.2/getting_started.html#getting-up-and-running-quickly-with-scaffolding

## Effective Developer

TIME SAVER #4: Customize and create your own scaffolds

https://github.com/code-and-effect/effective_developer

Go over what the scaffold did.

## More scaffolding

Scaffold Admin area too

TIME SAVER #4: Partials partials partials

## Add Approve and Decline scaffolding

rails generate migration add_approved_to_autopsies approved:boolean

def approve!
  raise 'already approved' if approved?s
  update!(approved: true)
end








