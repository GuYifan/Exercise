class LoginPage < BasePage
  section :login_form, '.new_user' do
    section :email, '.form-group', text: 'Email' do
      element :input, 'input'
    end
    section :password, '.form-group', text: 'Password' do
      element :input, 'input'
    end
    element :sign_in_button, '.btn.btn-primary', text: 'Sign in'
  end
end