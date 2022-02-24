Get in touch on Twitter <a href="https://twitter.com/axelmukwena">@axelmukwena</a> or email axel@stoiclab.com

# Documentation for https://elaka.io.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![](https://img.shields.io/badge/Ruby-3.0.0%2B-green.svg)]()
[![](https://img.shields.io/badge/Rails-6.1.3%2B-green.svg)]()
![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)

More on the dependency and package versions used are found in the [Gemfile](https://github.com/stoiclb/elaka/blob/main/Gemfile) and [Yarn](https://github.com/stoiclb/elaka/blob/main/package.json) files. <br/>
NB: This documentation is only accurately reproductible and tested on macOS Catalina. Checkout comphrensive [this book](https://www.railstutorial.org/book/beginning) by Michael Hartl, seems to touch Mac, Linux and Windows.

## License

All source code in this repository is available jointly under the Apache 2.0 License. See
[LICENSE](LICENSE.md) for details.

## Getting started

To get started with the app, first clone the repo and `cd` into the directory or alternaitively [Github Desktop](https://desktop.github.com/):

```
$ git clone https://github.com/stoiclb/elaka.git
$ cd elaka
```

Then install the needed packages (while skipping any Ruby gems needed only in production):

- Install [Yarn](https://classic.yarnpkg.com/en/docs/install/) v1.22.10
- Install [PostgreSQL](https://medium.com/@dan.chiniara/installing-postgresql-for-windows-7ec8145698e3) for Mac, Linux and Windows

```
$ gem install bundler -v 2.2.11
$ bundle _2.2.11_ config set --local
$ bundle install
```

(If you run into any installation issues or missing dependencies, refer to the [this book](https://www.railstutorial.org/book/beginning) by Michael Hartl.

Next, migrate the database:

```
$ rake db:migrate
```

I did not implement any automated tests, so skip the following testing stage:

```
$ rails test
$ rails db:seed
```

Run the app in a local server:

```
$ rails server
or 
$ rails s
```

You can then register a new user or log into an existing account.

## Deploying

To deploy the sample app to production, you’ll need a Heroku account (or any hosting platform of your choice).

The full production app includes several advanced features, including sending email with [MailGun](https://www.mailgun.com/). As a result, deploying the full sample app can be rather challenging.

```
$ heroku create
$ git checkout updating-users
$ git push heroku updating-users:main
$ heroku run rails db:migrate
$ heroku run rails db:seed
```

Visiting the URL returned by the original `heroku create` should now show you the sample app running in production. As with the local version, you can then register a new user or log in as the sample administrative user with the email `example@railstutorial.org` and password `foobar`.

## Branches


## Help

Experience shows that comparing code with the reference app is often helpful for debugging errors and tracking down discrepancies. For additional assistance with any issues in the tutorial, please consult the [Rails Tutorial Help page](https://www.railstutorial.org/help).

Suspected errors, typos, and bugs can be emailed to <axel@stoiclab.com>.
