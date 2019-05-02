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

So my name is Matt Riemer, I'm a full time ruby on rails developer and open sourcerer.

I'm one of these rare lucky people who gets to enjoy their day-to-day job. Most days.

So by day I'm a mild mannered co-founder and CTO of Code & Effect, the most effective web consultancy here in Edmonton.

https://codeandeffect.com/

One of the reasons I love my job is that I get to contribute to so much open source.

We've built literally dozens of websites and web apps that are right now running businesses online.

All that experience has been rolled into the effective_website and gems

All the code and everything you see here today is available on github.

You can follow along at this URL *point at slides*

## History

So I've built a lot of websites with rails.

And the sites I build are very traditional rails sites.

I fully embrace the patterns of CRUD, REST and try to embrace the Rails koolaid.

So after building the same address entry form, or payments checkout screen 3 or 4 times, a developer wants to DRY.

In the beginning days, rails 2, you couldn't even really build gems. You ended up copy and pasting things from project to project.

But with Rails 3.2, and rails engines, things really took off. All of a sudden you could bring code easily from project to project.

Well, this should appeal to any respectible developer.  The Do Not Repeat Yourself principle is high.

## Today

So today, I want to talk about:

- the starter rails 5 website that I use when starting a new project
- my collection of ruby on rails engines: the effective_* gems
- some of the time saving approaches you should be using in your apps

- Show off how I build a new feature, and use these tools to build CRUD websites quickly.


## Exploring the App Code - Round 1

It takes too darn long to make a fresh rails website. Nevermind an effective one.

TIME SAVER: Maintain your own stater template site.

https://github.com/code-and-effect/effective_website

This is the same process I use when evaluating any new rails app.

- Gemfile

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

Show off the website.


## Explore the App

https://localhost:3000

So, this is a fresh install of effective_website as per github with no other customizations made.

This is what I start with to begin a new client project.

You can see I am not a designer.  It's Twitter Bootstrap 4 but pretty unstyled.

Function over fashion.

Run through the app. Log in as admin@codeandeffect.com / any password

TIME SAVER: Development mode any password

- Home page. These are editable regions, I'll show that off later
- Blog
- Content Pages
- Style Guide

- Admin Users
- Admin Clients
- Pages
- Posts
- Logs
- Orders

## Exploring the App Code - Round 2

POP QUIZ: When receiving a web request, what is the first file that rails runs?

- routes.rb
  - talk about resources

POP QUIZ: What are the 7 restful routes?

https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions

- Member routes / collection routes

- ability.rb
  - action matches http and controller and route action

Controller
  - Admin::Clients#controller

- Tests controller

TIME SAVER: Have a secret endpoint that you can can test your app

Views
-  Layouts

TIME SAVER: A good layout

Other views

POP QUIZ: What files do you NOT see in these directories

Application Templates

TIME SAVER #3: Application templates

## Effective Bootstrap

Btw those `tabs do` and other helpers come from effective bootstrap gem.

https://github.com/code-and-effect/effective_bootstrap

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

  CAUSES = ['Organ failure', 'Smokers lung', 'Too many doritos']

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

## Effective Developer

TIME SAVER #3: Scaffolds

https://github.com/code-and-effect/effective_developer
























