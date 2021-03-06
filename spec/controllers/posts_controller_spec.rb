require 'spec_helper'

describe PostsController, :type => :controller do
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
        expect(assigns(:posts)).to eq([user_post])
      end

      it "doesn't have any drafts" do 
        get :index
        assigns(:posts).each do |post|
          post.published_on.should_not eq(nil)
        end
      end

    end

    context "GET show" do
      it "assigns the requested post as @post" do
        get :show, {:id => user_post.to_param}
        expect(assigns(:post)).to eq(user_post)
      end
    end

    context "GET new" do
      it "assigns a new post as @post" do
        sign_in user
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

    context "GET edit" do
      it "assigns the requested post as @post" do
        sign_in user
        get :edit, {:id => user_post.to_param}
        expect(assigns(:post)).to eq(user_post)
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
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        sign_in user
        post :create, {:post => post_attributes}
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Post).to receive(:save).and_return(false)
        post :create, {:post => { "title" => "invalid value" }}
        expect(response).to render_template("new")
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
        allow_any_instance_of(User).to receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => user_post.to_param, :post => { "title" => "MyString" }}
      end

      it "assigns the requested post as @post" do
        sign_in user
        put :update, {:id => user_post.to_param, :post => post_attributes}
        expect(assigns(:post)).to eq(user_post)
      end

      it "redirects to the post" do
        sign_in user
        put :update, {:id => user_post.to_param, :post => post_attributes}
        expect(response).to redirect_to(user_post)
      end

      it "updates the category correctly" do
        sign_in user
        put :update, {:id => user_post.to_param, :post => post_attributes.merge({ new_category: "farted" })}
        expect(assigns(:post).category.name).to eq("farted")
      end

    end

    context "with invalid params" do
      it "assigns the post as @post" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Post).to receive(:save).and_return(false)
        put :update, {:id => user_post.to_param, :post => { "title" => "invalid value" }}
        expect(assigns(:post)).to eq(user_post)
      end

      it "re-renders the 'edit' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Post).to receive(:save).and_return(false)
        put :update, {:id => user_post.to_param, :post => { "title" => "invalid value" }}
        expect(response).to render_template("edit")
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
      expect(response).to redirect_to(posts_url)
    end
  end 

  describe "Post replies" do
    let!(:user) { User.create user_attributes }
    let!(:user_post) { 
      user.posts.create! post_attributes
    }
    context "with no replies" do
      it "has a reply count of 0" do
        get :show, :id => user_post.to_param
        expect(assigns(:post).comments.count).to eq(0)
      end
    end

    context "with one reply" do
      it "creates a reply" do
        sign_in user
        expect {
          post :reply, { 
            :id   => user_post.to_param,
            :post => post_attributes
          }
        }.to change(Post, :count).by(1)
      end
    end
    context "with one reply to a reply" do
      it "creates a reply to a reply" do
        sign_in user
        parent = FactoryGirl.create(:post)
        child  = parent.comments.create(title: "I'm a reply to #{parent.title}", body: "fart")
        expect {
          post :reply, { 
            :id   => child.to_param,
            :post => post_attributes
          }
        }.to change(child.comments, :count).by(1)
      end
    end
  end

  describe "Drafts" do
    let!(:user) { User.create user_attributes }
    let!(:user_post) { user.posts.create! post_attributes }

    context "no drafts" do
      it "retrieves 0 drafts" do
        sign_in user
        get :drafts
        expect(assigns(:posts).count).to eq(0)
      end
    end
  end
end
