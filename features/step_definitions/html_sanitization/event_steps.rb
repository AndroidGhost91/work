Given(/^I'm creating a new event$/) do
  visit czardom_events.new_event_path

  fill_in "Title", with: 'you dirty rat'
  fill_in "Street*", with: '1337 programming ln.', exact: true
  fill_in "City", with: 'Oxford'
  fill_in "State", with: 'MS'
  fill_in "Zip Code", with: '38655'

  @html_form_page = HtmlSanitization.new
end
