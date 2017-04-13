### Overview of the Project ###

I want here to provide some insight into my thinking about this project.  

1) I choose to include the original data files in the project (located in '/db/data-files') and write a rake task for importing them into a Postgres database.  Ordinarily for a project going into production, I would import the files directly into a Postgres database and not have them live within the app.  

Here I wanted to demo the import process (or one way to do it).  Further, for an app going into production, I would have cleaned up the databases more thoroughly.  For example, one could write a method to add the missing player_ids in the "Master-small.csv" (which I call player-data.csv for the rake task).

2) If I were to take this project further, I would next add ways to for the user to create queries.  As of now, the database query for the Triple Crown Winner is hard coded to show the winner in 2012 and one has to manually re-write the query to determine if there was a winner for another year or league. It would not take much to pass in the params for league and/or year and use the params in the query as appropriate.

3) For production, there is still some set up to be done.  I would generally use the Figaro gem for managing secret keys in production, for example.

4) I have minimally styled the Stats view page.  For me the fun part of this particular project was working out the methods for pulling the appropriate data from the two data tables and massaging it into useable form.

5) Thanks for reviewing my code.  I would love the opportunity to work at SpringBot!