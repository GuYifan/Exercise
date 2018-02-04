class SignUpPage < BasePage
  section :sign_up_form, '.new_user' do
    section :email, '.form-group:nth-child(3)', text: 'Email' do
      element :input, 'input'
    end
    section :password, '.form-group:nth-child(4)', text: 'Password' do
      element :input, 'input'
    end
    section :password_confirmation, '.form-group:nth-child(5)', text: 'Password confirmation' do
      element :input, 'input'
    end
    element :sign_up_button, '.btn.btn-primary'
  end

  def sign_up(email, pwd)
    sign_up_form.email.input.set email
    sign_up_form.password.input.set pwd
    sign_up_form.password_confirmation.input.set pwd
    sign_up_form.sign_up_button.click
  end
end