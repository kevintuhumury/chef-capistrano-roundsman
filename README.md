# Chef (solo), Capistrano and Roundsman Bootstrap

This repository contains a collection of cookbooks and configuration files, which can be used to manage your server dependencies and deploy your Rails (or Sinatra) app. This is al made possible by [Chef](http://www.opscode.com/chef/) (solo), [Capistrano](https://github.com/capistrano/capistrano) and [Roundsman](https://github.com/iain/roundsman), which combines the two for easy deployment.

## Usage

Using all of this goodness, requires you to follow these easy steps:

1. `bundle install`
2. Edit `config/deploy.rb` (e.g. if you need to add a new stage) and `config/deploy/production.rb`. If you're using [Vagrant](http://vagrantup.com/), you might want to edit `config/deploy/vagrant.rb` also.

That's it. When using Vagrant, you'll want to deploy to that stage. This is done by running `cap vagrant deploy:setup` and after that `cap vagrant deploy`. If everything went according to plan, you can deploy to your actual server by running the `cap deploy:setup` (or `cap production deploy:setup`) command. When that's done, run: `cap deploy`.

## Note

This setup will install Apache, MySQL and Passenger and has been tested on Ubuntu 12.04 LTS.
