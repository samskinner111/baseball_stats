### Database Initialization ###

As a prerequisite, it is assumed that you have a PostgreSQL server setup on your development computer and are an administrative user. You will have two databases on your local to run and test this project. Both will be accessed by the "stat_user".

stat_development
stat_test

In the local development mode only, you may set up your own password or use the shared password 'dev-only:J4z3H9OKmPj7Kd5sVJxpaMY2Z4ilW67QAQ==zGtG9Y5fJFggwzeb'. Never use this password on a staging or production server. Every server must have its own unique password that is never stored in this repository.

To setup the databases for the first time, run psql as your admin user and then run the following SQL to configure the databases.

*** Create the development-only database user ***

In terminal, cd into the app and run:

psql < db/create_dev_only_user.sql

The db/create_dev_only_user.sql sets up the 'stat_user' as a superuser on your local development system.

*** Create the development databases ***

In terminal, run:

psql < db/rebuild_development.sql

### Database Import ###

To import the csv database, place the datafiles in a folder "data_files" inside "db".  Then run the following rake task.  (Note this assumes the csv file has been cleaned up, with header names as indicated in the rake task.)

rake db:seed:import_players
rake db:seed:import_batting

