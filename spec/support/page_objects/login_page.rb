class LoginPage < BasePage
  section :login_form, '.new_user' do
    section :email, '.form-group:nth-child(3)', text: 'Email' do
      element :input, 'input'
    end
    section :password, '.form-group:nth-child(4)', text: 'Password' do
      element :input, 'input'
    end
    element :sign_in_button, '.btn.btn-primary'
  end

  def login(email, pwd)
    login_form.email.input.set email
    login_form.password.input.set pwd
    login_form.sign_in_button.click
  end
end