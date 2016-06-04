# React-rb Showcase
This is a simple rails app showcasing React-rb, Opal and associated technologies. This showcase application is not intended as a tutorial but rather a set of examples that show how React-rb and associated technologies work together. This showcase is intended to be a companion project to the many excellent React-rb tutorials already written. 

### For an introduction to React-rb
+ [An overview of React-rb by Mitch VanDuyn](http://slides.com/mitchvanduyn/deck-1-3#/)
+ [Power of React-js with the joy of Ruby by Forrest Chang](http://www.slideshare.net/fkchang/reactrb-all-the-power-of-reactjs-with-all-the-joy-of-ruby)

### For more comprehensive tutorials please see some of these
+ [Getting started with React-rb and Rails](https://github.com/loicboutet/reactrb_tutorial)
+ [ChatRB Demo App](https://github.com/reactrb/reactrb.github.io/blob/master/docs/tutorial.md)
+ [Reactive Record sample ToDo app](https://github.com/loicboutet/reactivetodo)

### Other essential resources
+ [React-rb website](http://reactrb.org/)
+ [React-rb GitHub site](https://github.com/zetachang/react.rb)
+ [Opal website](http://opalrb.org/)

### React technologies you will need to understand
+ [The main React site](https://facebook.github.io/react/docs/getting-started.html)
+ [React Router](https://github.com/reactjs/react-router)

### React-rb Help, Problems, Questions, Issues

+ [Stack Overflow](http://stackoverflow.com/questions/tagged/react-rb) tag `react-rb` for specific problems.
+ [Gitter.im](https://gitter.im/zetachang/react.rb) for general questions, discussion, and interactive help.
+ [Github Issues](https://github.com/zetachang/react.rb/issues) for bugs, feature enhancements, etc.

### This showcase base technologies and philosophy 

The base infrastructure for this showcase is Rails 4.2.6 with Ruby 2.3.1. Please see their respective websites for details on how to install Rails and Ruby.

You will also need NPM installed. Please see the Node and NPM websites for instructions on how to install those technologies.

I suggest you use RVM to manage Ruby versions and NVM to manage Node versions. In this showcase we will be using NPM to install Node Modules and Webpack to deliver front end assets to Rails.

Ruby Gems are used as well, but more out of necessity than intent. I like to keep my front end and back end assets separate and in an ideal world, all my Rails related assets will be Ruby Gems and all the front end assets will be Node Modules installed by NPM. This is not always achievable and there are certainly edge cases which have an equal right in the back and front ends (like Opal and React-rb themselves). 

Several of the Ruby Gem versions of components we will use here come with their own source copy of React or React-Router. Personally I dont like this as I like to know and control the version of React and React-Router I am using as I find React does not play well with versions of it's self and I have wasted many an hour trying to work out what was going wrong only to find a spurious version of React included via a Gem. 

There is discussion in the React-rb community about removing React source so this may become a non-issue.

### Using NPM and Webpack alongside Rails 

I have found this to be an excellent combination which allows for all the front end assets to be installed via NPM which then play very nicely with Webpack which will co-exist happily with Sprockets. Pretty much every front end library is packaged with NPM these days so it is easy to get help and most things just work. 

## Step1: creating a new Rails application

	rails new reactrb-showcase
	cd reactrb-showcase
	bundle install

You should have a empty Rails application

	rails s

And in your browser

	http://localhost:3000/

You should be seeing the Rails Welcome aboard page. Great, Rails is installed. Lets get started with the interesting stuff.

