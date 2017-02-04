Then(/^I should receive an error that registration has ended$/) do
  expect(page).to have_text("Registration has ended")
end

#
# MISSING EMAIL
Given(/^I have an existing account in place$/) do
  file = File.read(Rails.root.join('fixtures', 'existing_user_stub.yml'))
  user = build(:user, YAML.load(file)['attributes'])
  user.save(validate: false)

  OmniauthFacebookResponses.existing_account(user.uid, {
    first_name: 'No',
    last_name: 'Email'
  })
end

When(/^I login to my existing account through facebook$/) do
  visit '/login'

  find('.facebook-login').click
end

Then(/^I should be logged in$/) do
  visit '/account'

  fill_in 'Email Address', with: 'real.ruta.fox@example.com'
  fill_in 'About You', with: 'I be the real ruta fox'
  fill_in 'Company', with: 'Ruta PR'

  fill_in 'Education', with: 'University'

  fill_in 'City', with: 'New York'
  fill_in 'State', with: 'NY'

  click_button 'Save Profile'

  OmniauthFacebookResponses.remove_mock
end

#
# MISSING EMAIL
When(/^I login with facebook without my email$/) do
  OmniauthFacebookResponses.missing_email({
    first_name: 'No',
    last_name: 'Email'
  })

  visit '/login'

  find('.facebook-login').click
end

Then(/^I should receive an error needing my email$/) do
  expect(page).to have_content("Email Address can't be blank")

  expect(find_field('First Name').value).to eq('No')
  expect(find_field('Last Name').value).to eq('Email')
  expect(find_field('About You').value).to eq('MISSING EMAIL BIO')

  expect(find_field('Website').value).to eq('MISSING-EMAIL.CO')
  expect(find_field('Education').value).to eq('University')

  expect(find_field('City').value).to eq('CITY')
  expect(find_field('State').value).to eq('STATE')

  OmniauthFacebookResponses.remove_mock
end

#
# MISSING LOCATION
When(/^I login with facebook without my location$/) do
  OmniauthFacebookResponses.missing_location({
    email: 'no-location@example.com',
    first_name: 'No',
    last_name: 'Location'
  })

  visit '/login'

  find('.facebook-login').click
end

Then(/^I should receive an error needing my location$/) do
  expect(find_field('First Name').value).to eq('No')
  expect(find_field('Last Name').value).to eq('Location')
  expect(find_field('About You').value).to eq('MISSING LOCATION BIO')

  expect(find_field('Website').value).to eq('MISSING-LOCATION.CO')
  expect(find_field('Education').value).to eq('University')

  expect(find_field('City').value).to be_blank
  expect(find_field('State').value).to be_blank

  OmniAuth.config.mock_auth[:facebook] = nil
end

#
# MISSING EDUCATION
When(/^I login with facebook without my education$/) do
  OmniauthFacebookResponses.missing_education({
    first_name: 'No',
    last_name: 'Education'
  })

  visit '/login'

  find('.facebook-login').click
end

Then(/^I should receive an error needing my education$/) do
  expect(page).to have_content("Education can't be blank")

  expect(find_field('First Name').value).to eq('No')
  expect(find_field('Last Name').value).to eq('Education')
  expect(find_field('About You').value).to eq('MISSING EDUCATION BIO')

  expect(find_field('Website').value).to eq('MISSING-EDUCATION.CO')
  expect(find_field('Education').value).to be_blank

  expect(find_field('City').value).to eq('CITY')
  expect(find_field('State').value).to eq('STATE')

  OmniAuth.config.mock_auth[:facebook] = nil
end

#
# MISSING WEBSITE
When(/^I login with facebook without my website$/) do
  OmniauthFacebookResponses.missing_website({
    first_name: 'No',
    last_name: 'Website'
  })

  visit '/login'

  find('.facebook-login').click
end

Then(/^I should receive an error needing my website$/) do
  expect(find_field('First Name').value).to eq('No')
  expect(find_field('Last Name').value).to eq('Website')
  expect(find_field('About You').value).to eq('MISSING WEBSITE BIO')

  expect(find_field('Website').value).to be_blank
  expect(find_field('Education').value).to eq('University')

  expect(find_field('City').value).to eq('CITY')
  expect(find_field('State').value).to eq('STATE')

  OmniAuth.config.mock_auth[:facebook] = nil
end

#
# MISSING PERSONAL DESCRIPTION
When(/^I login with facebook without my personal description$/) do
  OmniauthFacebookResponses.missing_description({
    first_name: 'No',
    last_name: 'Description'
  })

  visit '/login'

  find('.facebook-login').click
end

Then(/^I should receive an error needing my personal description$/) do
  expect(find_field('First Name').value).to eq('No')
  expect(find_field('Last Name').value).to eq('Description')
  expect(find_field('About You').value).to be_blank

  expect(find_field('Website').value).to eq('MISSING-DESCRIPTION.CO')
  expect(find_field('Education').value).to eq('University')

  expect(find_field('City').value).to eq('CITY')
  expect(find_field('State').value).to eq('STATE')

  OmniAuth.config.mock_auth[:facebook] = nil
end

#
# CONNECT TO FACEBOOK
When(/^I connect my account to facebook$/) do

  OmniauthFacebookResponses.existing_account('facebook-uid-for-connection', {})

  visit edit_user_path
  click_link "Connect to Facebook"
end

Then(/^my account connection should be updated$/) do
  @user.reload

  expect(@user.provider).to eq('facebook')
  expect(@user.uid).to eq('facebook-uid-for-connection')
  expect(@user.access_token).to eq('new-token-for-existing-user')
end
