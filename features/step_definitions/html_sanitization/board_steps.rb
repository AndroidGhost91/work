Given(/^I'm creating a new post$/) do
  Forem::Forum.create!(name: 'PR Resources', description: 'a resource for pr', category: Forem::Category.create!(name: 'forum-category'))

  visit new_board_path

  select 'PR Resources', from: 'Where are you looking?'
  fill_in 'Subject', with: 'Need a box of crayons'

  @html_form_page = HtmlSanitization.new
end
