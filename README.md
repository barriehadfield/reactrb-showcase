#React-rb Showcase
This is a simple rails app showcasing React-rb, Opal and associated technologies. This showcase application is not intended as a comprehensive tutorial but rather a set of examples that show how React-rb and associated technologies work together. This showcase is intended to be a companion project to the many excellent React-rb tutorials already written.

+ [Introduction and Resources](#introduction-and-resources)
+ [Setup Rails, React-rb and Webpack](#setup-rails-react-rb-and-webpack)

#Introduction and Resources

###Introductions to React-rb
+ [An overview of React-rb by Mitch VanDuyn](http://slides.com/mitchvanduyn/deck-1-3#/)
+ [Power of React-js with the joy of Ruby by Forrest Chang](http://www.slideshare.net/fkchang/reactrb-all-the-power-of-reactjs-with-all-the-joy-of-ruby)

###Comprehensive React-rb tutorials 
+ [Getting started with React-rb and Rails](https://github.com/loicboutet/reactrb_tutorial)
+ [ChatRB Demo App](https://github.com/reactrb/reactrb.github.io/blob/master/docs/tutorial.md)
+ [Reactive Record sample ToDo app](https://github.com/loicboutet/reactivetodo)

###Other essential resources
+ [React-rb website](http://reactrb.org/)
+ [React-rb GitHub site](https://github.com/zetachang/react.rb)
+ [Opal website](http://opalrb.org/)

###React-rb is powered by React 

React-rb and friends are in most cases simple DSL Ruby wrappers to the underlying native JavaScript libraries and React Components. It is really important to have a solid grip on how these technologies work to compliment your understanding of React-rb. Most searches for help on Google will take you to examples written in JSX or ES6 JavaScript but you will learn over time to transalte this to React-rb equivalents. To make headway with React-rb you do need a solid understanding of the underlying philosophy of React and its component based architecture. The 'Thinking in React' tutorial below is an excellent place to start.   

+ [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html)
+ [React](https://facebook.github.io/react/docs/getting-started.html)
+ [React Router](https://github.com/reactjs/react-router)
+ [React Bootstrap](https://react-bootstrap.github.io/)

###Opal under the covers

React-rb is a DSL wrapper of React which uses Opal to compile Ruby code to ES5 native JavaScript. If you have not used Opal before then you should at a minimum read the excellent Guids as they will teach you enough to get you started with React-rb. 

+ [Opal](http://opalrb.org/)
+ [Opal Guides](http://opalrb.org/docs/guides/v0.9.2/index.html)
+ [To see the full power of Opal in action watch this video](https://www.youtube.com/watch?v=vhIrrlcWphU)

###React-rb Help, Problems, Questions, Issues

+ [Stack Overflow](http://stackoverflow.com/questions/tagged/react-rb) tag `react-rb` for specific problems.
+ [Gitter.im](https://gitter.im/zetachang/react.rb) for general questions, discussion, and interactive help.
+ [Github Issues](https://github.com/zetachang/react.rb/issues) for bugs, feature enhancements, etc.

###This showcase base infrastructure and philosophy 

The base infrastructure for this showcase is Rails 4.2.6 with Ruby 2.3.1. Please see their respective websites for details on how to install Rails and Ruby.

You will also need NPM installed. Please see the Node and NPM websites for instructions on how to install those technologies.

I suggest you use RVM to manage Ruby versions and NVM to manage Node versions. In this showcase we will be using NPM to install Node Modules and Webpack to deliver front end assets to Rails.

Ruby Gems are used as well, but more out of necessity than intent. I like to keep my front end and back end assets separate and in an ideal world, all my Rails related assets will be Ruby Gems and all the front end assets will be Node Modules installed by NPM. This is not always achievable and there are certainly edge cases which have an equal right in the back and front ends (like Opal and React-rb themselves). 

Several of the Ruby Gem versions of components we will use here come with their own source copy of React or React-Router. Personally I dont like this as I like to know and control the version of React and React-Router I am using as I find React does not play well with versions of it's self and I have wasted many an hour trying to work out what was going wrong only to find a spurious version of React included via a Gem. 

There is discussion in the React-rb community about removing React source so this may become a non-issue.

### Using NPM and Webpack alongside Rails 

I have found this to be an excellent combination which allows for all the front end assets to be installed via NPM which then play very nicely with Webpack which will co-exist happily with Sprockets. Pretty much every front end library is packaged with NPM these days so it is easy to get help and most things just work. 

#Setup Rails, React-rb and Webpack

## Step 1: creating a new Rails application

	rails new reactrb-showcase
	cd reactrb-showcase
	bundle install

You should have a empty Rails application

	rails s

And in your browser

	http://localhost:3000/

You should be seeing the Rails Welcome aboard page. Great, Rails is installed. Lets get started with the interesting stuff.

## Step 2: adding React-rb

[We will use the React-rb Rails Generator Gem](https://github.com/loicboutet/reactive-rails-generator)

In your `Gemfile`

	gem "reactive_rails_generator"

then

	bundle update
	rails g reactrb:install
	bundle update

At this stage React-rb is installed but we dont have any components yet. Lets create via the generator:

	rails g reactrb:component Home::Show

This will add a new Component at app/views/components/home/show.rb

Have a look at this component as it provides the basis for all other React-rb components you will write. Note that all React-rb components inherit from `React::Component::Base` but you are free to `include React::Component::Base` instead if you prefer your components inheriting from other classes. Also note how params are set and the `before_mount` (etc) macros as you will use these extensively. Finally note that every component must have one `render` methord which must return just one DOM `element` which in this example case is a div. 

Next let's get this simple component rendering on a page. For that we will need a rails controller and a route.

