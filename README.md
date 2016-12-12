Wbooks API
===============

[![CircleCI](https://circleci.com/gh/epintos/wbooks-api.svg?style=svg&circle-token=b0edc574f8951c25e3a0bc38765205b73a76a24e)](https://circleci.com/gh/epintos/wbooks-api)
[![Error Tracking](https://d26gfdfi90p7cf.cloudfront.net/rollbar-badge.144534.o.png)](https://rollbar.com)

API Docs [here](http://docs.wbooksapi.apiary.io/)

## Running local server

### Git pre push hook

You can modify the [pre-push.sh](script/pre-push.sh) script to run different scripts before you `git push` (e.g Rspec, Linters). Then you need to run the following:

```bash
  chmod +x script/pre-push.sh
  ln -s ../../script/pre-push.sh .git/hooks/pre-push
```

You can skip the hook by adding `--no-verify` to your `git push`.

### 1- Installing Ruby

- Clone the repository by running `git clone git@github.com:Wolox/wbooks-api.git`
- Go to the project root by running `cd wbooks-api`
- Download and install [Rbenv](https://github.com/rbenv/rbenv#basic-github-checkout).
- Download and install [Ruby-Build](https://github.com/rbenv/ruby-build#installing-as-an-rbenv-plugin-recommended).
- Install the appropriate Ruby version by running `rbenv install [version]` where `version` is the one located in [.ruby-version](.ruby-version)

### 2- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
  gem install bundler --no-ri --no-rdoc
  rbenv rehash
```
- Install basic dependencies if you are using Ubuntu:

```bash
  sudo apt-get install build-essential libpq-dev nodejs
```

- Install all the gems included in the project.

```bash
  bundle -j 20
```

### Database Setup

Run in terminal:

```bash
  sudo -u postgres psql
  CREATE ROLE "wbooks-api" LOGIN CREATEDB PASSWORD 'wbooks-api';
```

Log out from postgres and run:

```bash
  bundle exec rake db:create db:migrate
```

Your server is ready to run. You can do this by executing `rails server` and going to [http://localhost:3000](http://localhost:3000). Happy coding!

## Running with Docker

Read more [here](docs/docker.md)

## Deploy Guide

#### Heroku

If you want to deploy your app using [Heroku](https://www.heroku.com) you need to do the following:

- Add the Heroku Git URL to your remotes
- Push to heroku

```bash
	git remote add heroku-prod your-git-url
	git push heroku-prod your-branch:master
```

## Rollbar Configuration

`Rollbar` is used for exception errors report. To complete this configuration setup the following environment variables in your server
- `ROLLBAR_ACCESS_TOKEN`

with the credentials located in the rollbar application.

If you have several servers with the same environment name you may want to difference them in Rollbar. For this set the `ROLLBAR_ENVIRONMENT` environment variable with your environment name.

## Google Analytics

Modified the `XX-XXXXXXX-X` code in the [_google_analytics.html.slim](app/views/layouts/_google_analytics.html.slim) file

## SEO Meta Tags

Just add a the `meta` element to your view.

For example

```html
  = meta title: "My Title", description: "My description", keywords: %w(keyword1 keyword2)
```

You can read more about it [here](https://github.com/lassebunk/metamagic)

## Brakeman

To run the static analyzer for security vulnerabilities run:

```bash
  bundle exec brakeman -z -i config/brakeman.ignore
```

## PGHero Authentication

Set the following variables in your server.

```bash
  PGHERO_USERNAME=username
  PGHERO_PASSWORD=password
```

And you can access the PGHero information by entering `/pghero`.

# Documentation

You can find more documentation in the [docs](docs) folder. The documentation available is:

- [Run locally with Docker](docs/docker.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rspec tests (`bundle exec rspec spec -fd`)
5. Run scss lint (`bundle exec scss-lint app/assets/stylesheets/`)
6. Run rubocop lint (`bundle exec rubocop app spec -R`)
7. Push your branch (`git push origin my-new-feature`)
8. Create a new Pull Request

## About

This project is maintained by [Esteban Guido Pintos](https://github.com/epintos) and it is written by [Wolox](http://www.wolox.com.ar).

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)
