#Reactrb Showcase

This is a simple rails app showcasing Reactrb, Opal and associated technologies. This showcase application is not intended as a comprehensive tutorial but rather a set of examples that show how Reactrb and associated technologies work together. This showcase is intended to be a companion project to the excellent Reactrb tutorials already written (see [Further Reading](#further-reading)).

+ [Introduction](#introduction)
	+ Introductions to Reactrb
	+ Reactrb Help and Questions
	+ This showcase base infrastructure and philosophy
	+ Using NPM and Webpack alongside Rails
+ [Setup](#setup)
	+ Step 1: Creating a new Rails application
	+ Step 2: Adding React-rb
	+ Step 3: Webpack for managing front-end assets
	+ Step 4: Installing React through NPM and Webpack
+ React Bootstrap
+ Reactrb-Router
+ [Further reading](#further-reading)
	+ Other Reactrb tutorials
	+ Other great resources
	+ Reactrb powered by React
	+ Opal under the covers

##Introduction

###Introductions to Reactrb
+ [An overview of Reactrb by Mitch VanDuyn](http://slides.com/mitchvanduyn/deck-1-3#/)
+ [Power of React-js with the joy of Ruby by Forrest Chang](http://www.slideshare.net/fkchang/reactrb-all-the-power-of-reactjs-with-all-the-joy-of-ruby)

###Reactrb Help and Questions

+ [Stack Overflow](http://stackoverflow.com/questions/tagged/react-rb) tag `reactrb` for specific problems.
+ [Gitter.im](https://gitter.im/zetachang/react.rb) for general questions, discussion, and interactive help.
+ [Github Issues](https://github.com/zetachang/react.rb/issues) for bugs, feature enhancements, etc.

###This showcase base infrastructure and philosophy 

The base infrastructure for this showcase is Rails 4.2.6 with Ruby 2.3.1. Please see their respective websites for details on how to install Rails and Ruby.

I like to keep my front-end and back-end assets separate and in an ideal world, all my Rails related assets would be Ruby Gems and all the front-end assets will be Node Modules installed by NPM. This is however not always achievable. 

To run this tutorial you will also need [NPM](https://www.npmjs.com/) and [Webpack](https://www.npmjs.com/package/webpack) installed. Please see the NPM websites for instructions on how to install these.

Several of the Gems we will use here come with their own source code copy of React or React-Router. Personally I don't like this as I like to know and control the version of React and React-Router I am using as I find React does not play well with versions of it's self and I have wasted many an hour trying to work out what was going wrong only to find a spurious version of React included via a Gem. 

### Using NPM and Webpack alongside Rails 

I have found this to be an excellent combination which allows for all the front end assets to be installed via NPM which then play very nicely with Webpack which will co-exist happily with Sprockets. Pretty much every front end library is packaged with NPM these days so it is easy to get help and most things just work. 

+ [NPM](https://www.npmjs.com/)
+ [Webpack](https://www.npmjs.com/package/webpack)

##Setup

###Step 1: Creating a new Rails application

	rails new reactrb-showcase
	cd reactrb-showcase
	bundle install

You should have a empty Rails application

	rails s

And in your browser

	http://localhost:3000/

You should be seeing the Rails Welcome aboard page. Great, Rails is now installed. Lets get started with the interesting stuff.

###Step 2: Adding Reactrb

[We will use the Reactrb Rails Generator Gem](https://github.com/loicboutet/reactive-rails-generator)

In your `Gemfile`

	gem "reactive_rails_generator"

then

	bundle update
	rails g reactrb:install
	bundle update

At this stage Reactrb is installed but we dont have any components yet. Lets create via the generator:

	rails g reactrb:component Home::Show

This will add a new Component at app/views/components/home/show.rb

Have a look at this component as it provides the basis for all other Reactrb components you will write. Note that all Reactrb components inherit from `React::Component::Base` but you are free to `include React::Component::Base` instead if you prefer your components inheriting from other classes. Also note how `params` are declared and the `before_mount` (and friends) macros as you will use these extensively. Finally note that every component must have one `render` methord which must return just one DOM `element` which in this example case is a `div`. 

Next let's get this simple component rendering on a page. For that we will need a rails controller and a route.

	rails generate controller home

And add a route to your `routes.rb`

	get 'home' => 'home#show'

A method in the HomeController which will render the component.

	class HomeController < ApplicationController
	  def show
	  end
	end

And finally a view app/views/home/show.erb

	<%= react_component "Home::Show" %>

And if all has gone well, you should be rewarded with `Home::Show` in your browser. If you open your JavaScript console you can also check which version of React has been loaded 

	React.version

At the time of writing this is returning `"0.13.3"` which is quite an old version of React which does not play nicely with many other React components. As I stated earlier, I am not in favour of Gems including React source code as I would rather manage this using NPM as it handles dependancies between front end components really well. With this in mind, the next thing we will do is install Webpack so we can have NPM manage our front end assets.

###Step 3: Webpack for managing front-end assets

[We will use the Webpack Rails Gem](https://github.com/mipearson/webpack-rails)

Run through the Installation instructions and you will end up with the following new files:

	package.json (for managing your NPM modules)
	procfile (for starting webpack-dev-server alongside your rails server)
	webpack\application.js (for requiring JavaScript libraries for inclusion by Webpack)
	config\webpack.config.js (for configuring Webpack)

Also note that your `.gitignore` now includes

	# Added by webpack-rails
	/node_modules
	/public/webpack

Assuming that you have NPM already installed (if you do not then you need to install it now), run

	npm install

which will download `webpack-dev-server` and other components into your `node-modules` folder. 

One final thing we need to do is add the entry point to our Rails application so Webpack can hot-load its assets in development mode

	<%= javascript_include_tag *webpack_asset_paths("application") %>

Assuming all went well you can now start your rails server agin using foreman

	foreman start

At this point you should have a working server with Webpack hot-loading any components added via NPM.

###Step 4: Installing React through NPM and Webpack

Installing React is very simple

	npm install react react-dom --save

This will install React (latest version) and also ReactDOM into your `node-modules` folder and also add the fact that these are installed to your `package.json`. You can now delete your `node-modules` folder at any time and simply `npm install` to install everything listed in `package.json`. Webpack does an excellent job of managing dependancies between NPM assets but you might find yourself deleting your `node-modules` folder fairly often as that is often the advice to resolve strange conflicts. 

Finally you need to `require` React and React DOM in webpack/application.js 

	window.React = require('react')
	window.ReactDOM = require('react-dom')

If you refresh your browser and check the React version should see the latest version ("15.1.0" at time of writing). You might also notice that there are warnings from React. 

	Warning: React.createElement: type should not be null, undefined, boolean, or number. It should be a string (for DOM elements) or a ReactClass (for composite components).

This has happened because there are now two different versions of React loaded - one from the Reactrb gem and one from Webpack! The warning is of course no help at all in determining that but I can save you many hours of searching as I eventually found that this was the problem. 

My solution to this problem has been to remove the older copy of React from the gem and rely on NPM and Webpack to install React as this gives me greater control of which precisely which version is being used. 

##Further reading

###Other Reactrb tutorials 
+ [Getting started with Reactrb and Rails](https://github.com/loicboutet/reactrb_tutorial)
+ [ChatRB Demo App](https://github.com/reactrb/reactrb.github.io/blob/master/docs/tutorial.md)
+ [Reactive Record sample ToDo app](https://github.com/loicboutet/reactivetodo)

###Other great resources
+ [Reactrb website](http://reactrb.org/)
+ [Reactrb GitHub site](https://github.com/zetachang/react.rb)
+ [Opal website](http://opalrb.org/)

###Reactrb is powered by React 

React-rb and friends are in most cases simple DSL Ruby wrappers to the underlying native JavaScript libraries and React Components. It is really important to have a solid grip on how these technologies work to compliment your understanding of React-rb. Most searches for help on Google will take you to examples written in JSX or ES6 JavaScript but you will learn over time to transalte this to React-rb equivalents. To make headway with React-rb you do need a solid understanding of the underlying philosophy of React and its component based architecture. The 'Thinking in React' tutorial below is an excellent place to start.   

+ [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html)
+ [React](https://facebook.github.io/react/docs/getting-started.html)
+ [React Router](https://github.com/reactjs/react-router)
+ [React Bootstrap](https://react-bootstrap.github.io/)

###Opal under the covers

Reactrb is a DSL wrapper of React which uses Opal to compile Ruby code to ES5 native JavaScript. If you have not used Opal before then you should at a minimum read the excellent guides as they will teach you enough to get you started with Reactrb. 

+ [Opal](http://opalrb.org/)
+ [Opal Guides](http://opalrb.org/docs/guides/v0.9.2/index.html)
+ [To see the full power of Opal in action watch this video](https://www.youtube.com/watch?v=vhIrrlcWphU)
