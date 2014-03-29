# Exportr: An environment manager for Ruby development
[![Code Climate](https://codeclimate.com/github/richardcalahan/exportr.png)](https://codeclimate.com/github/richardcalahan/exportr)
[![Build Status](https://travis-ci.org/richardcalahan/exportr.png?branch=master)](https://travis-ci.org/richardcalahan/exportr)

## Description

Exportr is a simple environment variable manager for Ruby development. It reads key-value pairs from a yaml file and merges these pairs into Ruby's ENV hash when the ruby process initializes.

## Basic Usage

Install the gem.

`$ gem install exportr`

Create an exportr.yml file in one of two locations relative to your project root.

    /exportr.yml
    /config/exportr.yml

## Rails

Exportr comes with a rails generator that will create `config/exportr.yml` and adds it to your `.gitignore` file.

Add the gem to your Gemfile

```
group :development do
  gem 'exportr'
end   
```

Run bundle install.

`$ bundle install`

Create an exportr.yml file in `config/exportr.yml`

`bundle exec rails g exportr`

Start your app server. 

`$ rails server`

**Notes**

You will need to restart your server/ruby process after changing the yaml file. You can optionally manually load additions to the yaml file by calling `Exportr.export`.








