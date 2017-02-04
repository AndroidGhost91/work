Given(/^I have an account with invalid data$/) do
  user = build(:user, email: 'bob@example.com', first_name: 'Bob', last_name: 'Wiley', password: 'forgotten password')
  user.education = nil
  user.work = nil
  user.save(validate: false)

  expect(user.persisted?).to be_truthy
  expect(user.valid?).to be_falsey
end

When(/^I reset my password$/) do
  visit '/users/password/new'

  # REQUEST RESET FORM
  fill_in 'Email Address', with: 'bob@example.com'
  click_button 'Send me reset password instructions'

  # GET TOKEN FROM EMAIL
  open_email('bob@example.com')
  expect(current_email.subject).to eq('Reset password instructions')
  if current_email.body.match(/reset_password_token=(\w+)/)
    token = $1
  end

  expect(token).to_not be_blank

  # RESET PASSWORD FORM
  visit "/users/password/edit?reset_password_token=#{token}"
  
  fill_in "user[password]", with: 'secret123'
  fill_in "Password confirmation", with: 'secret123'
  click_button "Change my password"

  expect(page).to_not have_text('Change your password')
end

Then(/^I should be able to log in$/) do
  visit "/login"
  
  fill_in "Email Address", with: 'bob@example.com'
  fill_in "Password", with: 'secret123'
  click_button 'Log In'

  expect(page).to have_content('Bob Wiley')
end
