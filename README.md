## Exportr: An environment manager for Ruby development

### Description

Exportr is a simple environment variable manager for Ruby development. It reads key-value pairs from a yaml file and merges these pairs into Ruby's ENV hash when you `require 'exportr'`.

The yaml file must be in one of Exportr's predefined locations. The paths are relative to the present working directory of the Ruby process. (The list will grow as Exportr is tested in various frameworks)

```

/exportr.yml
/config/exportr.yml

```

### Usage

**Basic**

1. Install the gem.

`$ gem install exportr`

2. Create an exportr.yml file in one of the predefined locations.

3. Require the gem.

`require 'exportr'`

**Rails**

Exportr comes with a rails generator that will create `config/exportr.yml` and add it to your `.gitignore` file.

1. Add the gem to your Gemfile

```

group :development do
  gem 'exportr'
end   

```

2. Run bundle install.

`$ bundle install`

3. Start your app server. 

`$ rails server`

**Notes**

You will need to restart your server/ruby process after changing the yaml file. You can optionally manually load additions to the yaml file by calling `Exportr.export`.








