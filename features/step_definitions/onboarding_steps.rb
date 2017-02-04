When(/^I create an account$/) do
  Product.create!(permalink: 'earlybird', name: 'testing-donation', price: 1000)

  visit new_user_path

  #
  # PROFILE DETAILS
  fill_in 'First Name', with: 'Bob'
  fill_in 'Last Name', with: 'Wiley'
  fill_in 'user[slug]', with: 'bobwiley'
  fill_in 'Email Address', with: 'bob.wiley@example.com'
  fill_in 'user[password]', with: 'secret123'
  fill_in 'Password confirmation', with: 'secret123'
  fill_in 'About You', with: "Don't hassle me. I'm local"
  fill_in 'Website', with: 'bob.wiley.com'
  fill_in 'Company', with: 'Self Employeed'
  fill_in 'Education', with: 'Harvard'

  #
  # LOCATION
  fill_in 'City', with: 'New York'
  fill_in 'State', with: 'NY'

  click_button 'Save Profile'

  @current_user = User.last
  expect(@current_user.slug).to eq('bobwiley')
end

When(/^I create an account with missing information$/) do
  step %q{I create an account}
  @current_user.education = nil
  @current_user.save(validate: false)
end

Then(/^I should be taken to fill in my missing information$/) do
  expect(page).to have_content("Education can't be blank")

  fill_in 'Education', with: 'Harvard'
  click_button 'Save Profile'
end

Then(/^I should be in the onboarding groups stage$/) do
  @current_user.reload
  expect(@current_user.state).to eq('onboarding_groups')
end

Then(/^I should be in the onboarding clients stage$/) do
  @current_user.reload
  expect(@current_user.state).to eq('onboarding_clients')
end

Then(/^I should be in the active stage$/) do
  @current_user.reload
  expect(@current_user.state).to eq('active')
end

Then(/^I should be automatically following default users$/) do
  expect(@current_user.following_users).to eq([@jenn, @john])
  expect(@current_user.following_user_ids).to include(@jenn.id, @john.id)
end

Then(/^I should be taken to pick groups$/) do
  expect(page).to have_content('Follow all the areas your are interested in')

  begin
    page.execute_script("$('input').show()")
  rescue Capybara::NotSupportedByDriverError => e
  end

  check('Sports')
  check('Music')
  check('Film')
  check('Dance')
  check('Money')

  within('.actions-lower') do
    click_button 'Continue'
  end

  @current_user.groups.reload
  group_ids = @groups.values.map(&:id)

  # expect(@current_user.group_ids).to include(*group_ids)
  # expect(@current_user.liked_group_ids).to include(*group_ids)
end

Then(/^I enter client information$/) do
  step %q{I should be taken to pick groups}

  fill_in 'Name', with: 'Dr. Leo'
  fill_in 'Website', with: 'deaththerapy.com'
  fill_in 'About', with: 'A great doctor and can help anyone with his radical Death Therapy'

  click_button 'Continue'
end

Then(/^I should be taken to the complete page$/) do
  expect(page).to have_content('Thank you for registering for Czardom')
  expect(page).to have_content('donate $18')
end
