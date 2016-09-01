module Components
  module Home
    class PostsList < React::Component::Base
      define_state :new_post, ""

      before_mount do
        # note that this will lazy load posts
        # and only the fields that are needed will be requested
        @posts = Post.all
      end

      def render
        div do
          new_post
          ul.list_unstyled do
            @posts.reverse.each do |post|
              PostListItem(post: post)
              CommentsList(comments: post.comments)
            end
          end
        end
      end

      def new_post
        ReactBootstrap::FormGroup() do
          ReactBootstrap::FormControl(
            value: state.new_post,
            type: :text,
          ).on(:change) { |e|
            state.new_post! e.target.value
          }
        end
        ReactBootstrap::Button(bsStyle: :primary) do
          "Post"
        end.on(:click) { save_new_post }
      end

      def save_new_post
        post = Post.new(body: state.new_post)
        post.save do |result|
          # note that save is a promise so this code will only run after the save
          # yet react will move onto the code after this (before the save happens)
          alert "unable to save" unless result == true
        end
        state.new_post! ""
      end
    end

    class PostListItem < React::Component::Base
      param :post

      def render
        li do
          # note how you access post.body just like with Active Record
          h4 { params.post.body }
        end
      end

    end
  end
end
