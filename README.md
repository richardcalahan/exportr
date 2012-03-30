# Exportr: an environment manager for rails development

## Quickstart

Add the gem to your Gemfile.

    gem 'exportr'

Install it!

    $ bundle install
    
Run the generator.

    $ rails generate exportr
    

The generator creates a yaml file in your config directory. It will store key:value pairs to be loaded as environment variables when your app launches. You can edit it manually, or use the command line utility.

### CLI