require 'spec_helper'

describe AttachmentsController, :type => :controller do
  include_context 'posts'
  include_context 'users'

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  let!(:user) { User.create! user_attributes }
  let!(:attachment) { FactoryGirl.attributes_for(:attachment) }

  def post_with_user(attachments) 
    sign_in user
    post :create, {
      :photo => { :imagefile => attachments[:attachment], :gallery => FactoryGirl.create(:gallery) },
      :public      => 1
    }
  end

  describe "POST attachment" do
    describe "with valid attachment" do
      it "creates a post with an attachment" do
        expect {
          post_with_user(attachment) 
        }.to change(Attachment, :count).by(1)
      end

      it "is a valid attachment object" do
        post_with_user(attachment)
        expect(assigns(:attachment)).to be_a(Attachment)
      end

      it "allows you to upload multiple images" do
        pending "Not supported yet"
        expect {
          # would love to find a better way to do this
          post_with_user([attachment, attachment, attachment])
        }.to change(Attachment, :count).by(3)
        assigns(:attachment).each { |a| a.should be_a(Attachment) }
      end
    end
  end


  describe "PUT update" do
    it "updates the requested attachment" do
      post_with_user(attachment)
      expect_any_instance_of(Attachment).to receive(:update).with({ "name" => "fart" })
      put :update, {:id => Attachment.first.to_param, :attachment => { "name" => "fart" }}
      expect(assigns(:attachment)).to eq(Attachment.first)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested attachment" do
      post_with_user(attachment)
      expect {
        delete :destroy, {:id => Attachment.first.to_param}
      }.to change(Attachment, :count).by(-1)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      post_with_user(attachment)
      get :index
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      post_with_user(attachment)
      get :show, {:id => Attachment.first.to_param, :format => 'json'}
      expect(response).to be_success
      expect(assigns(:attachment)).to eq(Attachment.first)
    end
  end

end
