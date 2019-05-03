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

I'm the co-founder and CTO of Code & Effect

https://codeandeffect.com/

One of our missions at Code & Effect is to contribute back to our community.

We do this in a lot of ways, and open source is one of those.

https://github.com/code-and-effect

So we've built a ton of client apps over the last 10 years.

Most of those apps are database CRUD apps.

That's exactly the style of sites that play to rails' strengths. And the kind I love building.

The effective gems make it super easy to build these kind of CRUD apps.

So today, we have about 30 minutes to get through the following 5 goals:

1.) A tour of my starter website app.
2.) A deep dive into code and how I evaluate a rails app I'm seeing for the first time.
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

https://github.com/code-and-effect/effective_website

TIME SAVER #1: Maintain your own stater template site.

This is the same process I use when evaluating any new rails app.

- Gemfile

POP QUIZ: Can anyone give me a 1 sentence quick description for all 12 of these gems?

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


Skip over Controllers and Datatables

Views
- Haml
- Layouts

TIME SAVER #2: A good layout.

- Navbars

https://github.com/code-and-effect/effective_bootstrap

Other views

POP QUIZ: What files do you NOT see in these directories.

Application Templates

https://guides.rubyonrails.org/action_view_overview.html#view-paths

TIME SAVER #3: Application templates


## Explore the App

https://localhost:3000

So, this is a fresh install of effective_website as per github with no other customizations made.

This is what I start with to begin a new client project.

You can see I am not a designer. It's Twitter Bootstrap 4 but pretty unstyled.

Function over fashion.

Run through the app. Log in as admin@codeandeffect.com / any password

- Home page. These are editable regions, I'll show that off later

- Blog
https://github.com/code-and-effect/effective_posts

- Content Pages
https://github.com/code-and-effect/effective_pages

- Style Guide
https://github.com/code-and-effect/effective_style_guide


TIME SAVER #4: Development mode any password

- Admin Users
https://github.com/code-and-effect/effective_datatables

- Admin Clients

- Impersonate

TIME SAVER #5: Impersonate user functionality. Let your admins admin the site.

- Logs
https://github.com/code-and-effect/effective_logging

- Orders
https://github.com/code-and-effect/effective_orders


## Exploring the App Code - Round 2

POP QUIZ: When receiving a web request, what is the first file that rails runs?

- routes.rb
  - talk about resources

- Tests controller

TIME SAVER #6: Have a secret endpoint that you can can test your app

POP QUIZ: What are the 7 restful routes? or the 7 CRUD actions

https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions

- Member routes / collection routes

- ability.rb
  - action matches http and controller and route action

Controller
  - Admin::Clients#controller

## Effective Resources

A big part of my process is trying not to write code.

The best code is no code at all. So to that end, I wrote

https://github.com/code-and-effect/effective_resources

It uses routes.rb, ability.rb and current_user and the controller to just do the right thing.

TIME SAVER #7: Don't write code at all

## So let's go and build something

The very first thing I do is write a model file. I sit for 30 minutes and think hard.

Semantic satiation
A psychological phenomenon in which repetition causes a word or phrase to temporarily lose meaning for the listener, 
who then perceives the speech as repeated meaningless sounds.

https://en.wikipedia.org/wiki/Semantic_satiation

- Create autopsy.rb

Then I type this, and I'm done!

rails generate effective:scaffold autopsy

To the app!

https://localhost:3000

## Scaffolds

TIME SAVER #8: Use scaffolds. They save you from typing out so much boilerplate.

rails generate

https://guides.rubyonrails.org/v3.2/getting_started.html#getting-up-and-running-quickly-with-scaffolding

## Effective Developer

TIME SAVER #9: Customize and create your own scaffolds

https://github.com/code-and-effect/effective_developer

Go over what the scaffold did.

## Admin scaffolding

Scaffold Admin area too

rails generate effective:scaffold_controller admin/autopsy crud-show

Go over what the scaffold built

- Notice the partials

TIME SAVER #10: Partials partials partials

## Add Approve and Decline scaffolding

So now let's go and add an action.

rails generate migration add_approved_to_autopsies approved:boolean

def approve!
  raise 'already approved' if approved?s
  update!(approved: true)
end

submit :approve, 'Approve it, yo!'

can(:approve, Autopsy) { }

resource_scope -> { current_user.autopsies }


## Conclusion

Okay, I think I'm out of time.

There's so much more we could talk about.

So in Conclusion, rails is awesome. 

If you're going to be building CRUD apps, effective gems are awesome.

Think about your own tech stack, what common patterns you see in the projects you work on. 

Extract and polish those patterns.

Don't repeat yourself.

Be effective.













