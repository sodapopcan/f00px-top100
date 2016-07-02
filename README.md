Top 100
=======

Set Up
------

You must provide your own consumer key for this app to work locally.

First run this command:

`cp config/settings.local.yml.tpl config/settings.local.yml`

Then edit `config/settings.local.yml` (which is `gitignore`'d) with your key.

This file is loaded via the [config gem](https://github.com/railsconfig/config)
which is my [current] favourite way to load env vars.  If this doesn't appear
to be working for you, try `spring stop`.
