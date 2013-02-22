# Exportr: An environment manager for Rails development

## Description

Managing environment variables locally is kind of a drag. If you only build one application at a time, you *could* simply export environment variables in your .bashrc. But in reality you're working on 5 apps at a time, each requiring different settings for Facebook, Google, AmazonS3, etc. 

If you set environment variables on your production servers to store configuration options for these services, you might also hard code 'default' options to fall back to on your local machine. Hardcoding default configuation options, especially private keys and passwords for third party apis is an *insane* security risk.

**Problem solved**.

Exportr helps you manage *local* environment variables. Each set is scoped to a specific rails application in `config/exportr.yml`. The file is 'git ignored' when created, so it never leaves your machine. Its key:value pairs are loaded as environment variables right before your application initializes.  

### Setup

Add the gem to your Gemfile.
    
    group :development do
      gem 'exportr'
    end   

Install it!

    $ bundle install
    
Run the generator.

    $ rails generate exportr
    
The generator creates a yaml file in your config directory. It will store key:value pairs to be loaded as environment variables when your app launches. You can edit it manually, or use the command line interface.

### CLI

You can edit the yaml config file directly, or use the handy CLI. There are several simple options for managing your configuration.  
You can use flags longform *e.g.* `--add, --remove, --clear, --list` or shorhand *e.g.* `-a, -r, -c, -l`.

**Add**

    $ exportr --add KEY=VALUE

**Remove**

    $ exportr --remove KEY

**Clear**    

    $ exportr --clear

**List**

    $ exportr --list

**Version**

    $ exportr --version

**Help**

    $ exportr --help

    
### FYI

You'll need to restart your webserver for the changes to take effect. 

### New Updates!

Exportr now supports system configuration files for production deployments of rails apps. By default, exportr will load the YAML file in /etc/#{application_name}_#{rails_env}.yml. The prefix, '/etc', can be overridden by setting the environment variable EXPORTR_PREFIX. 

Make sure the file is readable by your web process.
    
### License

Exportr &copy; 2012 by Richard Calahan and contributors at [All Day Every Day](http://alldayeveryday.com). It is licensed under the MIT license. See the include LICENSE file for details.
