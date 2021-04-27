Create app

$ rails new myapp --database=postgresql
$ rake db:setup
$ rake db:migrate
----------------------------------------------------------------------------

Update DB heroku
https://stackoverflow.com/questions/19097558/pg-undefinedtable-error-relation-users-does-not-exist

$ heroku run rake db:migrate

----------------------------------------------------------------------------

Basic Heroku set up important addons

https://jtway.co/how-to-setup-a-project-that-can-host-up-to-1000-users-for-free-ab59ad3edaf1

----------------------------------------------------------------------------
When css not reflecting, probably just change to !important, Rubymine kinda lags sometimes

----------------------------------------------------------------------------
Solve bundler problems

$ gem list | grep "bundle"

$ gem install bundler --version '2.2.11'
$ gem uninstall bundler --version '2.2.13'

Change global default bundler

$ bundler config default 2.2.11

Enable x86_64-linux Heroku

$ bundle lock --add-platform x86_64-linux

----------------------------------------------------------------------------
Check heroku config details

$ heroku config --app APP_NAME
$ heroku pg:info

----------------------------------------------------------------------------
Cannot see app? Restart 

$ heroku run rake db:migrate 
$ heroku restart -a APP_NAME


Database probably not set up


$ heroku addons:create heroku-postgresql 

or 

$ heroku addons:create heroku-postgresql:plan-name


----------------------------------------------------------------------------
Database GUI interface

https://github.com/sosedoff/pgweb

----------------------------------------------------------------------------
Handling domains?

https://support.dnsimple.com/articles/redirect-heroku/
https://www.lewagon.com/blog/buying-a-domain-on-namecheap-and-pointing-it-to-heroku


----------------------------------------------------------------------------
Bootstrap Tripping?

https://blog.makersacademy.com/how-to-install-bootstrap-and-jquery-on-rails-6-da6e810c1b87

----------------------------------------------------------------------------
Clear cache
$ rake tmp:cache:clear

----------------------------------------------------------------------------
Reset DB heroku
$ heroku pg:reset DATABASE

----------------------------------------------------------------------------
Email configuration
https://www.bogotobogo.com/RubyOnRails/RubyOnRails_Devise_Authentication_Sending_Confirmation_Email_Heroku_Deploy.php

----------------------------------------------------------------------------
Edit Credentials
https://www.youtube.com/watch?v=ggSyF1SVFr4&t=147s&ab_channel=tutoriaLinux

$ EDITOR="vim" bin/rails credentials:edit

----------------------------------------------------------------------------
Get all rails routes
http://localhost:3000/rails/info/routes

----------------------------------------------------------------------------
Recaptcha Tutorial
https://dev.to/morinoko/adding-recaptcha-v3-to-a-rails-app-without-a-gem-46jj

----------------------------------------------------------------------------
$ heroku logs

----------------------------------------------------------------------------
Mailgun Config Variables

MAILGUN_API_KEY
MAILGUN_DOMAIN
MAILGUN_PUBLIC_KEY
MAILGUN_SMTP_LOGIN
MAILGUN_SMTP_PASSWORD
MAILGUN_SMTP_PORT
MAILGUN_SMTP_SERVER

----------------------------------------------------------------------------
Setup Mailgun, Devise

https://dev.to/rmtwrk/how-to-fully-customize-rails-transactional-emails-devise-24ac

----------------------------------------------------------------------------
Migrations 

$ heroku run rails db:migrate --app elaka

----------------------------------------------------------------------------
SQL PG

select *
from entries
where user_id = '187' and created_at between 'April 10, 2021 15:00' and 'April 11, 2021 22:00';

----------------------------------------------------------------------------
$ rake db:rollback STEP=1

----------------------------------------------------------------------------
