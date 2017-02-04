Given(/^I'm editing my account$/) do
  visit edit_user_path(@user)
  @html_form_page = HtmlSanitization.new
end

Given(/^I have a nil about me$/) do
  @user.update_column(:about, nil)
end

Then(/^my profile bio should be blank$/) do
  visit user_path(@user)

  expect(find('.bio').text).to be_blank
end
