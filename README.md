# Exportr: an environment manager for rails development

## Description

Managing environment variables locally is kind of a drag. If you only build one application at a time, you *could* simply export environment variables in your .bashrc. 
But in reality you're working on 5 apps, each requiring different settings for Facebook, Google, AmazonS3, etc. 

You probably set environment variables on your production servers to store configuration options for these services. But you probably also hard code
'default' options to default to on your local machine. Hardcoding default configuation options, especially private keys for third party apis is an insane security risk.

Problem solved.

Exportr helps you manage local environment variables. Each set is scoped to a specific rails application in a local yaml file. The file is 'git ignored' when created, so it never leaves your machine. Its key:value pairs are loaded as environment variable when your application initializes.  

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