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

Now run `rake db:migrate` (even though there are no database models, it's just less error prone than
yanking db support out of a rails app).

Design
------

### Files of interest:

`lib/api_client.rb`:  This is a simple abstraction of an API client (backed by the [Excon
gem](https://github.com/excon/excon) for http).  While it is written to be extendable (ie, easy to
add wrappers for other verbs) it's slightly over-engineered for this case since all we need is `GET`.

`app/services/photo_service.rb`:  I like to use the service pattern when I can for grabbing external
data (as well as other tasks).  This is where the API business logic is stored.  It returns a custom
`Response` object with instances of `Photo` models.

`app/helpers/pager_helper.rb`:  This is a simple pager method convering only the case needed for this app (it
doesn't scale to a lot of pages).  If I were using database models I would use Kaminari.


### Models

I use [Virtus](https://github.com/solnic/virtus) for non-database backed models.  In the spirit of
not reinventing the wheel, this lets me declare associations a-la ActiveRecord and construct them by
passing raw JSON data.


Problems
--------

Due to the dynamic nature of always pulling in results from the API, the results can vary making it
possible to the see same photo on different pages (if their rating happens to change while
browsing).  This could be remedied by storing the results in a DB and updating daily or pre-fetching
all the results first, storing their IDs in a session variable, then querying off of the for the
rest of the session.
