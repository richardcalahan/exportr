# Exportr: an environment manager for rails development

## Description

Managing environment variables locally is kind of a drag. If you only build one application at a time, you could simply export environment variables in your .bashrc. 
But in reality you're working on 5 apps, each requiring different environment variables for Facebook, Google, AmazonS3 etc.

Problem solved.

Exportr helps you manage local environment variables: each set scoped to a specific rails application.  

### Setup

Add the gem to your Gemfile.

    gem 'exportr'

Install it!

    $ bundle install
    
Run the generator.

    $ rails generate exportr
    

The generator creates a yaml file in your config directory. It will store key:value pairs to be loaded as environment variables when your app launches. You can edit it manually, or use the command line utility.

### CLI

There are two simple options for use with the command line tool: **add** and **remove**.  
You can use flags longform `--add` or shorhand `-a`.

    $ exportr --add KEY=VALUE
or

    $ exportr --remove KEY
    
### FYI