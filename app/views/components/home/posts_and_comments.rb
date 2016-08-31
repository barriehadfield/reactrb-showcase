module Components
  module Home
    class PostsAndComments < React::Component::Base

      define_state :posts, []

      before_mount do
        state.posts! []
      end

      after_mount do
        state.posts! Post.all
      end

      def render
        div do
          new_post
          ul do
            state.posts.each do |post|
              # li { post.body }
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
        end.on(:click) { create_new_post }
      end

      def create_new_post
        # post = Post.new
        # post.body = @new_post
        # post.save
      end

    end
  end
end
