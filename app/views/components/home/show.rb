module Components
  module Home

    class Show < React::Component::Base

      # param :my_param
      # param param_with_default: "default value"
      # param :param_with_default2, default: "default value" # alternative syntax
      # param :param_with_type, type: Hash
      # param :array_of_hashes, type: [Hash]
      # collect_all_other_params_as :attributes  #collects all other params into a hash

      define_state :show, false

      # The following are the most common lifecycle call backs,
      # the following are the most common lifecycle call backs# delete any that you are not using.
      # call backs may also reference an instance method i.e. before_mount :my_method

      before_mount do
        # any initialization particularly of state variables goes here.
        # this will execute on server (prerendering) and client.
        # @todos = []
        state.todos! Todo.all
        # @todos = Todo.all
      end

      after_mount do
        # any client only post rendering initialization goes here.
        # i.e. start timers, HTTP requests, and low level jquery operations etc.
        # state.show! false
        # @todos = Todo.all
        # @final = Todo.last
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

      # def render
      #   div do
      #     h1 {"here is the list"}
      #     # table do
      #     todos = state.todos || []
      #       todos.each do |todo|
      #         ul do
      #           li { para {todo.title} }
      #           li {para {"empty"}}
      #           # li { para {todo.things.count} }
      #         end
      #       end
      #     # end
      #   end
      # end

      # def render
      #   ul do
      #     state.todos.each do |todo|
      #       li { todo.title }
      #       ul do
      #         # state.things! Thing.all.where(todo_id: todo.id)
      #         # Thing.all.where(todo_id: todo.id).each do |thing|
      #         Thing.for_todo(todo.id).each do |thing|
      #           li { thing.name }
      #         end
      #       end
      #     end
      #   end
      # end
 

      def render
        ul do
          state.todos.each do |todo|
            li { todo.title }
            ul do
              todo.things.each do |thing|
                li { thing.name }
              end
            end
          end
        end
      end

       # def render
  #        div do
  #          ReactBootstrap::Navbar(bsStyle: :inverse) do
  #          ReactBootstrap::Nav() do
  #            ReactBootstrap::NavbarBrand() do
  #              a(href: '#') { 'Reactrb Showcase' }
  #            end
  #            ReactBootstrap::NavDropdown(eventKey: 1, title: 'Things', id: :drop_down) do
  #              (1..5).each do |n|
  #                ReactBootstrap::MenuItem(href: '#', key: n, eventKey: "1.#{n}") do
  #                  "Number #{n}"
  #                end.on(:click) { say_hello(n) }
  #              end
  #            end
  #          end
  #         end
  #         # h1 {"hello change"}
  #         # ReactPlayer(url: 'https://www.youtube.com/embed/FzCsDVfPQqk', playing: true)
  #         # button {"click"}.on(:click) { state.show! true }
  #         # if state.show
  #           @todos.each do |todo|
  #             h1 { "#{todo.title }"}
  #             things = todo.things || []
  #             things.each do |thing|
  #               h2 { "thing: #{thing.name}, created: #{thing.created_at}"}
  #               h3 { thing.special_name }
  #             end
  #           end
  #         # end
  #         button {"more"}.on(:click) do
  #           tt=Todo.new
  #           tt.title = "Added here again and after"
  #           tt.save
  #         end
  #         # h5 {@final.title} if @final
  #       end
  #      end

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
