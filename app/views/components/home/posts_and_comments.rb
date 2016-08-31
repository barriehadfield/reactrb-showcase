module Components
  module Home
    class PostsAndComments < React::Component::Base

      # define_state :posts

      # before_mount do
      #   # this is needed as we are pre-rendering
      #   # state.posts! []
      # end

      before_mount do
        @posts = Post.all
      end

      def render
        div do
          new_post
          ul do
            @posts.each do |post|
              li { post.body }
            end
          end
        end
      end

      def new_post
        ReactBootstrap::FormGroup() do
          ReactBootstrap::FormControl(
            type: :text,
          ).on(:change) { |e|
            @new_post = e.target.value
          }
        end
        ReactBootstrap::Button(bsStyle: :primary) do
          "Post"
        end.on(:click) { save_new_post }
      end

      def save_new_post
        post = Post.new(body: @new_post)
        post.save do |result|
          # note that save is a promise
          alert "unable to save" unless result[:success]
        end
      end

    end
  end
end
