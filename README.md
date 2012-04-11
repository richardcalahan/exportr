# Exportr: An environment manager for Rails development

## Description

Managing environment variables locally is kind of a drag. If you only build one application at a time, you *could* simply export environment variables in your .bashrc. But in reality you're working on 5 apps at a time, each requiring different settings for Facebook, Google, AmazonS3, etc. 

You probably set environment variables on your production servers to store configuration options for these services. Yet you might also hard code 'default' options to fall back to on your local machine. Hardcoding default configuation options, especially private keys and passwords for third party apis is an *insane* security risk.

**Problem solved**.

Exportr helps you manage local environment variables. Each set is scoped to a specific rails application in `config/exportr.yml`. The file is 'git ignored' when created, so it never leaves your machine. Its key:value pairs are loaded as environment variables when your application initializes.  

### Setup

Add the gem to your Gemfile.

    gem 'exportr'

Install it!

    $ bundle install
    
Run the generator.

    $ rails generate exportr
    
The generator creates a yaml file in your config directory. It will store key:value pairs to be loaded as environment variables when your app launches. You can edit it manually, or use the command line interface.

### CLI

There are four simple options for use with the command line tool: **add**, **remove**, **clear** and **list**.  
You can use flags longform `--add, --remove, --clear, --list, --version, --help` or shorhand `-a, -r, -c, -l, -v, -h`.

    $ exportr --add KEY=VALUE

    $ exportr --remove KEY
    
    $ exportr --clear
    
    $ exportr --list

    $ exportr --version

    $ exportr --help

    
### FYI

You'll need to restart your webserver for the changes to take effect. 
    
### License

Exportr &copy; 2012 by Richard Calahan and contributors at [All Day Everyday](http://alldayeveryday.com). It is licensed under the MIT license. See the include LICENSE file for details.
