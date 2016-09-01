module Components
  module Home
    class PostsList < React::Component::Base

      before_mount do
        @posts = Post.all
      end

      def render
        div do
          new_post
          ul do
            @posts.reverse.each do |post|
              PostListItem(post: post)
              # note how you access associated models
              CommentsList(comments: post.comments)
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
          # note that save is a promise so this code will only run after the save
          # yet react will move onto the code after this (before the save happens)
          alert "unable to save" unless result == true
        end
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
