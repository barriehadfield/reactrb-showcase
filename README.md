# Reactrb Showcase - DRAFT

This is a simple Rails application showcasing Reactrb, Opal, NPM, Webpack, React Bootstrap and other associated technologies.  This showcase is intended to be a companion project to the excellent Reactrb tutorials already written which you can find in [Further Reading](#further-reading) below.

+ [Introduction](#introduction)
+ [Setup](#setup)
+ [Working with React Bootstrap](#working-with-react-bootstrap)
+ Reactrb Router
+ Opal IRB
+ Reactrb Hotloader
+ Reactrb Reactive Record
+ [Further reading](#further-reading)

## Introduction

### Introductions to Reactrb
+ [An overview of Reactrb by Mitch VanDuyn](http://slides.com/mitchvanduyn/deck-1-3#/)
+ [Power of React-js with the joy of Ruby by Forrest Chang](http://www.slideshare.net/fkchang/reactrb-all-the-power-of-reactjs-with-all-the-joy-of-ruby)

### Reactrb Help and Questions

+ [Gitter.im](https://gitter.im/reactrb/chat) for general questions, discussion, and interactive help.
+ [Stack Overflow](http://stackoverflow.com/questions/tagged/reactrb) tag `reactrb` for specific problems.
+ [Github Issues](https://github.com/reactrb/reactrb/issues) for bugs, feature enhancements, etc.

### Using NPM and Webpack alongside Rails

I like to keep my front-end and back-end assets separate and in an ideal world, all my Rails related assets would be Ruby Gems and all the front-end assets will be Node Modules installed by NPM. This is however not always achievable.

I have found Webpack and Rails to be an excellent combination which allows for all the front end assets to be installed via NPM which then play very nicely with Webpack which will co-exist happily with Sprockets. Pretty much every front end library is packaged with NPM these days so it is easy to get help and most things just work.

+ [NPM](https://www.npmjs.com/)
+ [Webpack](https://www.npmjs.com/package/webpack)

This tutorial requires that Ruby, Rails, NPM and Webpack are installed. Please see their websites for installation instructions.

### Technologies highlighted in this showcase app

+ For the backend we are using Rails 4.2.6 with Ruby 2.3.1
+ NPM and Webpack to manage front end assets
+ [React Rails](https://github.com/reactjs/react-rails) to use React with Rails
+ [Reactrb](https://github.com/reactrb/reactrb) to write reactive UI components with Ruby's elegance
+ [React Bootstrap](https://react-bootstrap.github.io/) to show how to use native React components in Reactrb

## Setup

### Step 1: Creating a new Rails application

	rails new reactrb-showcase
	cd reactrb-showcase
	bundle install

You should have a empty Rails application

	rails s

And in your browser

	http://localhost:3000/

You should be seeing the Rails Welcome aboard page. Great, Rails is now installed. Lets get started with the interesting stuff.

### Step 2: Adding Reactrb

[We will use the Reactrb Rails Generator Gem](https://github.com/loicboutet/reactive-rails-generator)

In your `Gemfile`

	gem "reactrb-rails-generator"

then

	bundle update
	rails g reactrb:install
	bundle update

At this stage Reactrb is installed but we don't have any components yet. Lets create via the generator:

	rails g reactrb:component Home::Show

This will add a new Component at app/views/components/home/show.rb

```
module Components
  module Home
    class Show < React::Component::Base

      # param :my_param
      # param param_with_default: "default value"
      # param :param_with_default2, default: "default value" # alternative syntax
      # param :param_with_type, type: Hash
      # param :array_of_hashes, type: [Hash]
      # collect_all_other_params_as :attributes  #collects all other params into a hash

      # The following are the most common lifecycle call backs,
      # the following are the most common lifecycle call backs# delete any that you are not using.
      # call backs may also reference an instance method i.e. before_mount :my_method

      before_mount do
        # any initialization particularly of state variables goes here.
        # this will execute on server (prerendering) and client.
      end

      after_mount do
        # any client only post rendering initialization goes here.
        # i.e. start timers, HTTP requests, and low level jquery operations etc.
      end

      before_update do
        # called whenever a component will be re-rerendered
      end

      before_unmount do
        # cleanup any thing (i.e. timers) before component is destroyed
      end

      def render
        div do
          "Home::Show"
        end
      end
    end
  end
end
```

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

A note on React versions: Reactrb includes the [React Rails](https://github.com/reactjs/react-rails) gem which includes a copy of the React source. Multiple copies of React being included cause untold problems so pay particular attention to the version of React you have (via the React Rails gem) and the version we are about to install via NPM. We will need to ensure these versions are the same. At the time writing, the React version being installed is 15.0.2 so we install the same version via NPN. See [React Rails - React  versions](https://github.com/reactjs/react-rails/blob/master/VERSIONS.md) for a list of React versions supported by different versions of the React Rails gem. In a moment we are going to change this configuration so that Webpack loads React so we do need to pay attention to the version of React we will install to ensure it matches with a version we know React Rails supports.

### Step 3: Webpack for managing front-end assets

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

One final thing we need to do is add the entry point to our Rails application so Webpack can hot-load its assets in development mode. This must be added __BEFORE__ your other `_javascript_include_tag`, so your `assets\javascripts\application.js` should look like this
```
<head>
	<title>ReactrbShowcase</title>
	<%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
	<%= javascript_include_tag  *webpack_asset_paths("application") %>
	<%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
	<%= csrf_meta_tags %>
</head>
```
__Three Golden Rules__ when working with Webpack, Rails, React and Reactrb:

We are now expecting two sets of technologies (Rails with Sprockets) and (NPM with Webpack) to play nicely together and `require` the correct front-end assets at the correct time. In addition to that, `Webpack-dev-server` is running in the background eagerly re-compiling our Webpack assets whenever it sees a change. Believe it or not, this does all work well __provided__ you follow these three golden rules:

+ Webpack assets must be included and load __before__ the Rails ones (as per the change we have made above)
+ React pre-rendering will not work while you are using `Webpack-dev-server` as the Webpack assets are delivered directly into the browser. To see pre-rendering working you will need to compile your Webpack assets manually with `rake webpack:compile` and then switch off the dev server by adding this line to `application.rb`: `::Rails.configuration.webpack.dev_server.enabled = false`
+ Ensure that your components and libraries are installed either by Webpack (via NPM) or bt Rails (via a GEM) and never by both. If you start getting error messages saying that you are including two copies of React this will be the most likely cause.

Assuming all went well you can now start your rails server agin using foreman (which starts webpack_dev_server and rails at the same time)

	foreman start

At this point you should have a working server with Webpack hot-loading any components added via NPM. Time to add some front end assets via NPM!

### Step 4: Installing React using NPM and Webpack

Installing React is very simple via NPM (note the @version which matches the version of React we have established is compatible with the React Rails gem above).

	npm install react@15.0.2 react-dom@15.0.2 --save

This will install React and also ReactDOM into your `node-modules` folder and also add the fact that these are installed to your `package.json`. You can now delete your `node-modules` folder at any time and simply `npm install` to install everything listed in `package.json`. Webpack does an excellent job of managing dependancies between NPM assets but you might find yourself deleting your `node-modules` folder fairly often as that is often the advice to resolve strange conflicts.

Now we need to tell Webpack that its its job to load React and ReactDOM by the following to `webpack/application.js`

	React = require('react')
	ReactDOM = require('react-dom')

And then of course (following the Three Golden Rules above), we need to make sure that React is not being included by Rails anywhere else.

In `views/components.rb` make sure React is __not__ required

	require 'opal'
	# require 'react'
	require 'reactrb'

And check your `assets/javascripts/application.js` to ensure that React has not been required there. If it has then remove it.

If you refresh your browser and check the React version should see the latest version ("15.1.0" at time of writing). If you are seeing that version number and no React warnings then all has worked properly and we are ready to start writing some Reactrb components.

## Working with React Bootstrap

[We will be using React Bootstrap which is a native React library](https://react-bootstrap.github.io/)

The main purpose for React Bootstrap is that it abstracts away verbose HTML & CSS code into React components which makes it a lot cleaner for React JSX developers. One of the very lovely things about Reactrb is that we already work in beautiful Ruby. To emphasise this point, consider the following:

Sample 1 - In HTML (without React Bootstrap):

	<button id="something-btn" type="button" class="btn btn-success btn-sm">
	  Something
	</button>
	$('#something-btn').click(someCallback);

Sample 2 - In JSX (with React Bootstrap components):

	<Button bsStyle="success" bsSize="small" onClick={someCallback}>
	  Something
	</Button>

Sample 3 - In Reactrb (without React Bootstrap):

	button.btn_success.btn_sm {'Something'}.on(:click) do
		someMethod
	end

Sample 4 - In Reactrb (with React Bootstrap):

	Bs.Button(bsStyle: 'success' bsSize: "small") {'Something'}.on(:click) do
		someMethod
	end

As you can see, sample 3 & 4 are not that different and as a Reactrb developer, I actually prefer sample 3. If I were a JavaScript or JSX developer I would completely understand the advantage of abstracting Bootstrap CSS into React Components so I don't have to work directly with CSS and JavaScript but this is not the case with Reactrb as CSS classes are added to HTML elements with simple dot notation:

	span.pull_right {}

compiles to (note the conversion from _ to -)

	<span class='pull-right'></span>

So I hear you ask: why if I prefer the non-React Bootstrap syntax why am worrying about React Bootstrap? For one very simple reason: components like Navbar and Modal that requires `bootstrap.js` will not work with React so without the React Bootstrap project you would need to implement all that functionality yourself. The React Bootstrap project has re-implemented all this functionality as React components.

Lets implement a Navbar in this project using React Bootstrap in Reactrb. First, we need to install Bootstrap and React Bootstrap:

	npm install bootstrap react-bootstrap --save

And then we need to `require` it in webpack/application.js

	ReactBootstrap = require('react-bootstrap')

I have also downloaded `bootstrap.css` and added it `assets/stylesheets`. This is a bit of a cheat as I am sure it can be included by Webpack, but for simplicity I have opted for this approach.

If you refresh your browser now and open the JavaScript console we will be able to interact with React Bootstrap

In the JavaScript console type: ```ReactBootstrap```

and you will see the ReactBootstrap object with all its components like Accordion, Alert, Badge, Breadcrumb, etc. This is great news, React Bootstrap is installed and ready to use. Accessing the JavaScript object in this way is a really great way to see what you have to work with. Sometimes the documentation of a component is not as accurate as actually seeing what you have in the component itself.

Lets recap for a second. We have Reactrb working with an initial component and we have React Bootstrap installed and ready to use, but there is a key piece of the puzzle missing. How do we bridge between Ruby and JavaScript so that we can use a JavaScript based library alongside our beautiful Ruby based components?

Reactrb makes this unbelievably easy which is a testament to its elegance, power and simplicity. We simply wrap the JavaScript library in a Ruby class and access it through Ruby. Lets do that next then we will be ready to write our Bootstrap Nav component in Ruby.

Create a new folder `views/components/shared` and add a file `bootstrap.rb` (I like to keep all my shared components in a specific folder and then one folder per application concept)

	module Components
		class Bs < React::NativeLibrary
			imports 'ReactBootstrap'
		end
	end

The code above defines a new class `Bs` which `imports` the JavaScript based React Bootstrap library for us to use in Ruby with our Reactrb components. We are wrapping a JavaScript library with a Ruby class.

Lets go ahead and create our Navbar::Show component in `views/components/navbar/show.rb`

	module Components
		module Navbar
			class Show < React::Component::Base

				def say_hello
					alert "Hello!"
				end

				def render
					div {
						div(id: "main-navbar") {
							Bs.Navbar(bsStyle: :inverse) {
								Bs.Nav {
									Bs.NavbarBrand { a(href: '#') {"Reactrb Showcase"} }
									Bs.NavDropdown(eventKey: 1, title: "Things", id: :drop_down) {
										(1..5).each do |n|
											Bs.MenuItem(key: n, eventKey: "1.#{n.to_s}", href: '#' ) {
												"Number #{n.to_s}"
											}.on(:click) { say_hello }
										end
									}
								}
							}
						}
					}
				end
			end
		end
	end

A few things to notice in the code above:

We add React Bootstrap components simply by `Bs.Name` where `Name` is the component you want to create. All the components are documented in the React Bootstrap [documentation](https://react-bootstrap.github.io/components.html)

Notice how I have added an `.on(:click)` event handler to the `MenuItem` component while setting `href: '#'` as this will allow us to handle the event instead of navigating to a new page.

Finally a point on Ruby syntax. Reactrb employs extensive use of Ruby blocks as you can see in the syntax above. You have a choice when enclosing your blocks with `{ }` or `do end`. Ruby coding guidelines suggest that you should use `{ }` for one line blocks and `do end` for anything longer. When working with Reactrb, I prefer using `{ }` for html elements and `do end` for any programming logic or looping. I find `div { }` more readable and natural than `div do end`. If you disagree then feel free to use whatever works best for you.

TODO:

+ Reactrb Router
+ Opal IRB
+ Reactrb Hotloader
+ Reactrb Reactive Record

## Further reading

### Other Reactrb tutorials and examples
+ [Getting started with Reactrb and Rails](https://github.com/loicboutet/reactrb_tutorial)
+ [ChatRB Demo App](https://github.com/reactrb/reactrb.github.io/blob/master/docs/tutorial.md)
+ [Reactive Record sample ToDo app](https://github.com/loicboutet/reactivetodo)
+ [Flux pattern in Reactrb](https://github.com/reactrb/reactrb.github.io/wiki/Sending-data-from-deeply-nested-components)
+ [Getting with Reactrb, React Bootstrap and Webpack](https://github.com/fkchang/getting-started-reactrb-webpack)

### Other Reactrb resources
+ [Reactrb website](http://reactrb.org/)
+ [Reactrb GitHub site](https://github.com/reactrb/reactrb)

### Reactrb is powered by React

Reactrb and friends are in most cases simple DSL Ruby wrappers to the underlying native JavaScript libraries and React Components. It is really important to have a solid grip on how these technologies work to compliment your understanding of Reactrb. Most searches for help on Google will take you to examples written in JSX or ES6 JavaScript but you will learn over time to transalte this to Reactrb equivalents. To make headway with Reactrb you do need a solid understanding of the underlying philosophy of React and its component based architecture. The 'Thinking in React' tutorial below is an excellent place to start. (Make sure you see the Flux pattern in Reactrb above for an example of how to communicate between grandparent and child components).   

+ [Thinking in React](https://facebook.github.io/react/docs/thinking-in-react.html)
+ [React](https://facebook.github.io/react/docs/getting-started.html)
+ [React Router](https://github.com/reactjs/react-router)
+ [React Bootstrap](https://react-bootstrap.github.io/)

### Opal under the covers

Reactrb is a DSL wrapper of React which uses Opal to compile Ruby code to ES5 native JavaScript. If you have not used Opal before then you should at a minimum read the excellent guides as they will teach you enough to get you started with Reactrb.

+ [Opal](http://opalrb.org/)
+ [Opal Guides](http://opalrb.org/docs/guides/v0.9.2/index.html)
+ [To see the full power of Opal in action watch this video](https://www.youtube.com/watch?v=vhIrrlcWphU)
