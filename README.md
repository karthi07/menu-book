# Menu Book Uploader

As a big restaurant owner, User should to set up an online menu for my restaurant.

Build a web application, where user can upload an excel sheet OR CSV with the dishes sold in thier restaurant.

## Tools Used
- Ruby on Rails
- Postgresql
- sidekiq [background job processing]

## Deployment steps

### build process


postgresql setup
 - setup postgresql at your local machine 
 -  update the username password in the database.yml file
 

    1. clone the repo
    2. bundle install
    3. bundle exec rake assets:precompile SKIP_CSS_BUILD=true
    4. bundle exec rake assets:clean
    5. bundle exec rake db:migrate
    6. bundle exec rake db:seed



### start server
    1. rails s
    2. bundle exec sidekiq 


## Online version

Deployed using render. 

https://menu-book.onrender.com/

^ note: upload data will not work, as render doesnot provide backgound job setup in free version
https://render.com/docs/deploy-sidekiq-worker


## Todo

    - [] add pagination
    - [] reload menu page after job is completed