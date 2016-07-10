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

      def say_hello(i)
        alert "Hello from number #{i}"
      end

       def render
         div do
           ReactBootstrap::Navbar(bsStyle: :inverse) do
           ReactBootstrap::Nav() do
             ReactBootstrap::NavbarBrand() do
               a(href: '#') { 'Reactrb Showcase' }
             end
             ReactBootstrap::NavDropdown(eventKey: 1, title: 'Things', id: :drop_down) do
               (1..5).each do |n|
                 ReactBootstrap::MenuItem(href: '#', key: n, eventKey: "1.#{n}") do
                   "Number #{n}"
                 end.on(:click) { say_hello(n) }
               end
             end
           end
          end
          ReactPlayer(url: 'https://www.youtube.com/embed/FzCsDVfPQqk', playing: true)
        end
       end

      # def render
      #   div do
      #     ReactBootstrap::Button(bsStyle: 'success', bsSize: "small") do
      #       'Success'
      #     end.on(:click) do
      #       alert('you clicked me!')
      #     end
      #   end
      # end
    end
  end
end
