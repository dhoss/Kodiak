require 'spec_helper'

describe AttachmentsController do
  include_context 'test_preparation'
  include_context 'posts'
  include_context 'users'

  before(:each) do
    setup
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  after(:each) do
    teardown
  end
  
  let!(:user) { User.create! user_attributes }
  let!(:attachment) { FactoryGirl.attributes_for(:attachment) }

  def post_as_json(attachments) 
    sign_in user
    post :create, {
      :attachments => attachments[:attachment],
      :public      => 1
    }
  end

  describe "POST attachment" do
    describe "with valid attachment" do
      it "creates a post with an attachment" do
        expect {
          post_as_json(attachment) 
        }.to change(Attachment, :count).by(1)
      end

      it "is a valid attachment object" do
        post_as_json(attachment)
        assigns(:attachment).should be_a(Attachment)
      end

      it "allows you to upload multiple images" do
        pending "Not supported yet"
        expect {
          # would love to find a better way to do this
          post_as_json([attachment, attachment, attachment])
        }.to change(Attachment, :count).by(3)
        assigns(:attachment).each { |a| a.should be_a(Attachment) }
      end
    end
  end


  describe "PUT update" do
    it "updates the requested attachment" do
      post_as_json(attachment)
      Attachment.any_instance.should_receive(:update_attributes).with({ "attachment" => "fart.jpg" })
      put :update, {:id => Attachment.first.to_param, :attachments => { "attachment" => "fart.jpg" }}
      assigns(:attachment).should eq(Attachment.first)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested attachment" do
      post_as_json(attachment)
      expect {
        delete :destroy, {:id => Attachment.first.to_param}
      }.to change(Attachment, :count).by(-1)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      post_as_json(attachment)
      get :index
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      post_as_json(attachment)
      get :show, {:id => Attachment.first.to_param, :format => 'json'}
      response.should be_success
      assigns(:attachment).should eq(Attachment.first)
    end
  end

end
