require 'spec_helper'

describe PostsController do
  include_context 'posts'
  include_context 'users'

 describe "GET" do 
   let!(:user) { User.create user_attributes }
    subject(:user_post) do
      user.posts.create! post_attributes, 
                       :category => { :name => "toots"},
                       :tag_attributes => [{ :name => "fartaculous" }] 
    end

    context "GET index" do
      it "assigns all posts as @posts" do
        get :index
        assigns(:posts).should eq([user_post])
      end
    end

    context "GET show" do
      it "assigns the requested post as @post" do
        get :show, {:id => user_post.to_param}
        assigns(:post).should eq(user_post)
      end
    end

    context "GET new" do
      it "assigns a new post as @post" do
        sign_in user
        get :new
        assigns(:post).should be_a_new(Post)
      end
    end

    context "GET edit" do
      it "assigns the requested post as @post" do
        sign_in user
        get :edit, {:id => user_post.to_param}
        assigns(:post).should eq(user_post)
      end
    end
 end
  describe "POST create" do
    let!(:user) { User.create user_attributes }
    subject(:user_post) do
    user.posts.create! post_attributes, 
                     :category => { :name => "toots"},
                     :tag_attributes => [{ :name => "fartaculous" }] 
    end
    context "with valid params" do
      it "creates a new Post" do
        sign_in user
        expect {
          post :create, {:post => post_attributes}
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        sign_in user
        post :create, {:post => post_attributes}
        assigns(:post).should be_a(Post)
        assigns(:post).should be_persisted
      end

      it "redirects to the created post" do
        sign_in user
        post :create, {:post => post_attributes}
        response.should redirect_to(Post.last)
      end
    end

    describe "POST attachment" do
      context "with valid attachment" do
        it "creates a post with an attachment" do
          sign_in user
          expect {
            post :create, {
              :post => post_attributes.merge(attachments_attributes: [ FactoryGirl.attributes_for(:attachment) ])
            }
          }.to change(Attachment, :count).by(1)
        end

        it "is a valid attachment object" do
          sign_in user
          post :create, {
              :post => post_attributes.merge(attachments_attributes: [ FactoryGirl.attributes_for(:attachment) ])
          }
          assigns(:post).attachments.first.should be_a(Attachment)
        end

        it "allows you to upload multiple images" do
          sign_in user
          expect {
            post :create, {
              :post => post_attributes.merge(attachments_attributes: [ 
                FactoryGirl.attributes_for(:attachment), FactoryGirl.attributes_for(:attachment), FactoryGirl.attributes_for(:attachment)
              ])
            }
          }.to change(Attachment, :count).by(3)
          assigns(:post).attachments.each { |a| a.should be_a(Attachment) }
        end
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    let!(:user) { User.create user_attributes }
    subject(:user_post) do
      user.posts.create! post_attributes, 
                     :category => { :name => "toots"},
                     :tag_attributes => [{ :name => "fartaculous" }] 
    end
    context "with valid params" do
      it "updates the requested post" do
        sign_in user
        # Assuming there are no other posts in the database, this
        # specifies that the Post created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Post.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => user_post.to_param, :post => { "title" => "MyString" }}
      end

      it "assigns the requested post as @post" do
        sign_in user
        put :update, {:id => user_post.to_param, :post => post_attributes}
        assigns(:post).should eq(user_post)
      end

      it "redirects to the post" do
        sign_in user
        put :update, {:id => user_post.to_param, :post => post_attributes}
        response.should redirect_to(user_post)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => user_post.to_param, :post => { "title" => "invalid value" }}
        assigns(:post).should eq(user_post)
      end

      it "re-renders the 'edit' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => user_post.to_param, :post => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:user) { User.create user_attributes }
    let!(:user_post) {
      user.posts.create! post_attributes, 
                     :category => { :name => "toots"},
                     :tag_attributes => [{ :name => "fartaculous" }] 
    }
    it "destroys the requested post" do
      sign_in user
      expect {
        delete :destroy, {:id => user_post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      sign_in user
      delete :destroy, {:id => user_post.to_param}
      response.should redirect_to(posts_url)
    end
  end 
end
