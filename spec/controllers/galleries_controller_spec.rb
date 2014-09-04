require 'spec_helper'

describe GalleriesController do
  include_context 'users'
  let!(:attachment) { FactoryGirl.attributes_for(:attachment) }
  let!(:user) { User.create user_attributes }
  let(:gallery) { FactoryGirl.attributes_for(:gallery) }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all galleries as @galleries" do
      gallery = Gallery.create! gallery
      get :index
      assigns(:galleries).should eq([gallery])
    end
  end

  describe "GET show" do
    it "assigns the requested gallery as @gallery" do
      gallery = Gallery.create! gallery
      get :show, {:id => gallery.to_param}
      assigns(:gallery).should eq(gallery)
    end
  end

  describe "GET new" do
    it "assigns a new gallery as @gallery" do
      sign_in user
      get :new
      assigns(:gallery).should be_a_new(Gallery)
    end
  end

  describe "GET edit" do
    it "assigns the requested gallery as @gallery" do
      sign_in user
      gallery = Gallery.create! gallery
      get :edit, {:id => gallery.to_param}
      assigns(:gallery).should eq(gallery)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Gallery" do
        gallery[:cover] = attachment[:attachment] 
        sign_in user
        expect {
          post :create, gallery
        }.to change(Gallery, :count).by(1)
      end

      it "assigns a newly created gallery as @gallery" do
        sign_in user
        post :create, gallery
        assigns(:gallery).should be_a(Gallery)
        assigns(:gallery).should be_persisted
      end

      it "redirects to the created gallery" do
        sign_in user
        post :create, gallery
        response.should redirect_to(Gallery.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved gallery as @gallery" do
        # Trigger the behavior that occurs when invalid params are submitted
        sign_in user
        Gallery.any_instance.stub(:save).and_return(false)
        post :create, {"name" => "invalid value" }
        assigns(:gallery).should be_a_new(Gallery)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        sign_in user
        Gallery.any_instance.stub(:save).and_return(false)
        post :create, {"name" => "invalid value"}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested gallery" do
        sign_in user
        gallery = Gallery.create! gallery
        # Assuming there are no other galleries in the database, this
        # specifies that the Gallery created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Gallery.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => gallery.to_param, "name" => "MyString" }
      end

      it "assigns the requested gallery as @gallery" do
        sign_in user
        gallery = Gallery.create! gallery
        put :update, {:id => gallery.to_param, "name" => "Fart"}
        assigns(:gallery).should eq(gallery)
      end

      it "redirects to the gallery" do
        sign_in user
        gallery = Gallery.create! gallery
        put :update, {:id => gallery.to_param, "name" => "Fart"}
        response.should redirect_to(:action => :show, :id => "fart")
      end
    end

    describe "with invalid params" do
      it "assigns the gallery as @gallery" do
        sign_in user
        gallery = Gallery.create! gallery
        # Trigger the behavior that occurs when invalid params are submitted
        Gallery.any_instance.stub(:save).and_return(false)
        put :update, {:id => gallery.to_param, "name" => "invalid value" }
        assigns(:gallery).should eq(gallery)
      end

      it "re-renders the 'edit' template" do
        sign_in user
        gallery = Gallery.create! gallery
        # Trigger the behavior that occurs when invalid params are submitted
        Gallery.any_instance.stub(:save).and_return(false)
        put :update, {:id => gallery.to_param, "name" => "invalid value" }
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested gallery" do
      sign_in user
      gallery = Gallery.create! gallery
      expect {
        delete :destroy, {:id => gallery.to_param}
      }.to change(Gallery, :count).by(-1)
    end

    it "redirects to the galleries list" do
      sign_in user
      gallery = Gallery.create! gallery
      delete :destroy, {:id => gallery.to_param}
      response.should redirect_to(galleries_url)
    end
  end
end
