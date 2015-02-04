require 'spec_helper'

describe UsersController, :type => :controller do
  include_context 'posts'
  include_context 'users'

  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  let(:valid_session) { {} }
  let!(:user) { User.create! valid_attributes }

  describe "GET index" do
    it "assigns all users as @users" do
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, {:id => user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      sign_in user
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      sign_in user
      get :edit, {:id => user.to_param}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:user) {User.new(name: "farty mcfart", email: "fart123@fart.com", password: "fart12345")}
      it "creates a new User" do
        expect {
          post :create, {:user => user.to_h }
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => user.to_h}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => user.to_h}
        expect(response).to redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(User).to receive(:save).and_return(false)
        post :create, {:user => { "name" => "invalid value" }}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(User).to receive(:save).and_return(false)
        post :create, {:user => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        sign_in user
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(User).to receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => user.to_param, :user => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested user as @user" do
        sign_in user
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        sign_in user
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        expect(response).to redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(User).to receive(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(User).to receive(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      sign_in user
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      sign_in user
      delete :destroy, {:id => user.to_param}, valid_session
      expect(response).to redirect_to(users_url)
    end
  end
end
