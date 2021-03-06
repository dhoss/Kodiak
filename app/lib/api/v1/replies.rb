module API
  module V1
    class Replies < Grape::API
      include ActionView::Helpers::OutputSafetyHelper
      include Grape::Rails::Cache

      version 'v1'
      format :json

      resource :replies do
        desc "Return replies for a given post"
        route_param :id do
          get do
            # this should go somewhere else
            post = Post.includes(:user).friendly.find(params[:id])
           
            cache(key: "api:replies:#{post.id}", etag: post.updated_at, expires_in: 2.minutes) do
              post.reply_tree.map{ |reply| 
                reply.merge({'body' => reply.delete('body').html_safe}) 
              }
            end
          end
        end
      end
    end
  end
end
