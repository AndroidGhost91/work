When(/^I log in by email$/) do
  visit '/login'

  fill_in 'Email', with: 'bob@example.com'
  fill_in 'Password', with: 'secret123'

  click_button 'Log In'
end

When(/^I log in with a missing email$/) do
  visit '/login'

  fill_in 'Email', with: 'alice@example.com'
  fill_in 'Password', with: 'secret123'

  click_button 'Log In'
end

Then(/^I should be taken to my account$/) do
  expect(page).to have_content('Bob Wiley')
end

Then(/^I should receive a login error$/) do
  expect(page).to have_content('Invalid email address or password.')
end
