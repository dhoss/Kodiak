module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'user[email]',     with: email
      fill_in 'user[password]',  with: password
      fill_in 'user[password_confirmation]', with: password
      click_button 'Sign up'
    end

    def sign_in
      user = create(:user)
      visit new_user_session_path
      print page.html
      fill_in 'user[email]',    with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Sign in'
    end
  end
 end
