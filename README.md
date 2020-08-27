# Viewing Party / Movie Night
<!-- [Viewing Party production site](https://peaceful-journey-75998.herokuapp.com/) -->

Developers: [Kathy Bui](http://github.com/kathybui732) and [AJ Tran](http://github.com/ajtran303/)

This is repo for our paired project for Turing's Backend Module 3.

### About this Project

Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friend's.

## Usage and Features

<!-- Visit the [production site](https://peaceful-journey-75998.herokuapp.com/) to use Viewing Party and its features. -->

### Known issues

The production site is down. [Screenshots of the functionality can be found here.](https://github.com/Kathybui732/viewing_party/issues/53)

Currently, you can log in with your Google Account. We use `OAuth` to delegate authentication to a third party.

Once logged in, you are ready to `Discover Movies.` You can either find out the top 40 highest rated movies in the database or try a keyword search for movie titles.

On the movie search results index page, you can click any movie title to go to a page to see more details for that specific movie.

Back on the dashboard (where you were after logging in), you can add friends. Search for your friend by email address! If your friend's email address is registered, then you will have added them as a friend! Friendships are reciprocal -- which means that you don't need to wait for them to "accept" your request -- the both of you just become friends!

### Features in progress

Coming soon: you will be able to "Create a Viewing Party," which will automatically add an event to your Google Calendar with a movie's information and friends that you have added and invited.

## Local Setup

First, make sure you are using `Ruby 2.5.3` and `Rails 5.2.4.3`

1. Fork and Clone the repo and `cd viewing_party`
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{create,migrate}`
4. Configure the secret API keys for your development environment

### API Keys Setup

This app requires several API keys to be configured. We use the `figaro` gem to manage the configuration so that the keys may remain secret in the codebase.

That means, you will have to register and configure your own API keys.

1. Get Google Key and Secret from the [Google APIs Developers Console](https://console.developers.google.com/)
2. You will need to register for a TMDB API Key from [The Movie DataBase](https://developers.themoviedb.org/3/getting-started/introduction)


Once you have your keys, run this command in the terminal:

```
bundle exec figaro install
```

This command will generate a .gitignored `config/.application.yml` Open that file and fill in the following key-value pairs:

```
GOOGLE_CLIENT_ID: <YOUR CLIENT ID>
GOOGLE_CLIENT_SECRET: <YOUR CLIENT SECRET>
TMDB_API_KEY: <YOUR TMDB API KEY>

# For example:

# GOOGLE_CLIENT_ID: 564adg13asf245asfa4
# GOOGLE_CLIENT_SECRET: 564adg13asf245asfa4
# TMDB_API_KEY: 564adg13asf245asfa4
```

### Run the test suite

Once everything is set up, you're ready to run the tests!

```
bundle exec rspec
```
