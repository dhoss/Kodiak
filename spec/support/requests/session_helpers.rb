module Requests
  module SessionHelpers
    def sign_up_with(email, password)
      get new_user_registration_path
      expect(response).to render_template(:new)

      post user_registration_path, {
        user: {
          email: email,
          password: password,
          password_confirmation: password
        }
      }
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("Welcome! You have signed up successfully.")
    end

    def sign_in
      user_attrs = FactoryGirl.attributes_for(:user)
      email      = user_attrs[:email]
      password   = user_attrs[:password]

      sign_up_with(email, password)
      post user_session_path, {
        user: {
          email: email,
          password: password
        }
      }
    end
  end
 end
