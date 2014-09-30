module API
  module V1
    class Replies < Grape::API
      version 'v1'
      format :json

      resource :replies do
        desc "Return replies for a given post"
        route_param :id do
          get do   
            Post.with_author.friendly.find(params[:id]).reply_tree
          end
        end
      end
    end
  end
end
