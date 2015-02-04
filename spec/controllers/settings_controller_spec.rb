require 'spec_helper'
require 'factory_girl' 

describe SettingsController, :type => :controller do

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all settings as @settings" do
      setting = Setting.distinct_settings
      get :index, {}, valid_session
      expect(assigns(:settings)).to eq(setting)
    end
  end

  describe "GET show" do
    it "assigns the requested setting as @setting" do
      setting = Setting.first
      get :show, {:id => setting.to_param}, valid_session
      expect(assigns(:setting)).to eq(setting)
    end
  end

  describe "GET new" do
    it "assigns a new setting as @setting" do
      get :new, {}, valid_session
      expect(assigns(:setting)).to be_a_new(Setting)
    end
  end

  describe "GET edit" do
    it "assigns the requested setting as @setting" do
      setting = Setting.first
      get :edit, {:id => setting.to_param}, valid_session
      expect(assigns(:setting)).to eq(setting)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Setting" do
        expect {
          post :create, {:setting => FactoryGirl.attributes_for(:setting)}, valid_session
        }.to change(Setting, :count).by(1)
      end

      it "assigns a newly created setting as @setting" do
        post :create, {:setting => FactoryGirl.attributes_for(:setting)}, valid_session
        expect(assigns(:setting)).to be_a(Setting)
        expect(assigns(:setting)).to be_persisted
      end

      it "redirects to the created setting" do
        post :create, {:setting => FactoryGirl.attributes_for(:setting)}, valid_session
        expect(response).to redirect_to(Setting.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved setting as @setting" do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Setting).to receive(:save).and_return(false)
        post :create, {:setting => { :configuration => { :balls => "invalid" }}}
        expect(assigns(:setting)).to be_a_new(Setting)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Setting).to receive(:save).and_return(false)
        post :create, {:setting => { :configuration => { :balls => "invalid" }}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested setting" do
        setting = Setting.first
        # Assuming there are no other settings in the database, this
        # specifies that the Setting created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Setting).to receive(:update).with({ "these" => "params" })
        put :update, {:id => setting.to_param, :setting => { "these" => "params" }}, valid_session
      end

      it "assigns the requested setting as @setting" do
        setting = Setting.first
        put :update, {:id => setting.to_param, :setting => FactoryGirl.attributes_for(:setting)}, valid_session
        expect(assigns(:setting)).to eq(setting)
      end

      it "redirects to the setting" do
        setting = Setting.first
        put :update, {:id => setting.to_param, :setting => FactoryGirl.attributes_for(:setting)}, valid_session
        expect(response).to redirect_to(setting)
      end
    end

    describe "with invalid params" do
      it "assigns the setting as @setting" do
        setting = Setting.first
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Setting).to receive(:save).and_return(false)
        put :update, {:id => setting.to_param, :setting => {:configuration => { :balls => "fart"}  }}, valid_session
        expect(assigns(:setting)).to eq(setting)
      end

      it "re-renders the 'edit' template" do
        setting = Setting.first
        # Trigger the behavior that occurs when invalid params are submitted
        expect_any_instance_of(Setting).to receive(:save).and_return(false)
        put :update, {:id => setting.to_param, :setting => {:configuration => {:balls=>"fart"}}}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested setting" do
      setting = Setting.first
      expect {
        delete :destroy, {:id => setting.to_param}, valid_session
      }.to change(Setting, :count).by(-1)
    end

    it "redirects to the settings list" do
      setting = Setting.first
      delete :destroy, {:id => setting.to_param}, valid_session
      response.should redirect_to(settings_url)
    end
  end

end
