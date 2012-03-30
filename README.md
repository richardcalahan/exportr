# Exportr: an environment manager for rails development

## Quickstart

Add the gem to your Gemfile.

    gem 'exportr'

Install it!

    $ bundle install
    
Run the generator.

    $ rails generate exportr
    

This will generate a yaml file in your config directory. It will store key:value pairs to be loaded
as environment variables when your app launches. 

rails generate exportr

Add environment variables to config/exportr.yml:

FACEBOOK_APP_ID: '124323434564'