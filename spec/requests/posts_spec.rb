require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "gets posts listing successfully" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
    end
  end

  describe "PUT /posts/:id" do
    it "updates a post with a new category properly" do
      sign_in
      expect {
        post posts_url, {
          post: {
            title: "pfffft",
            body: "fllippppbbbbthhhhtttt",
            new_category: "fart"
          }
        }
      }.to change(Post, :count).by(1)

      expect { 
        put "/posts/#{Post.find_by(title: "pfffft").slug}", 
          post: {
            new_category: "pffft"
          }
        
      }.to change(Category, :count).by(1)
    end
  end

end
