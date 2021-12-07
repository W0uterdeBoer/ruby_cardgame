# Software stack
focussing on ruby and ruby on rails 
specifically
- ruby
- ruby on rails
- turbo, both turbo-frames an turbo-stream

# Layers
We use a standard MVC layout
We have do not use any database.
This gives us three layers.
- The Model, written in plain ruby
- the View, consisting of .erb files and css
- the Controlers, also written in ruby but heavily dependent on the ruby on rails framework.

# file structure
The file structure is standard for a ruby on rails application.
- The models can be found in app/models
- the view can be found in app/view
- the controlers can be found in app/controller
- the routing of websites can be found in config/routes.rb
- some layout related files can be found in app/assets
- stuff related to websockets can be found in app/channels and app/java

As such, each layer is contained in a seperate subfile.
