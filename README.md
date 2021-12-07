# Core idea
We want to make a trading card game. 
Users should be able to go to a site and play a game against each other. 
Each using a different window, such that they cannot see each others cards.
Users should be able to play all cards in their hand an move monster cards over the field.
There will be very few cards, but the project will be extendable.

# Installation
to run the server one needs 
- ruby
- ruby on rails
- rake
- bundle
- the included gemfile

we recommend https://guides.rubyonrails.org/getting_started.html for further details
further more remember to run "bundle install" to install the required gems and their dependencies.

# Running
To run the application run "rails s" 
the first player should go to localhost:3000, this creates a game
the second player should go to localhost:3000/join. this joins said game on the other side

# testing
"rake test does not yet provide the desired results.
we recommend going to the test directory and running the files maually.
