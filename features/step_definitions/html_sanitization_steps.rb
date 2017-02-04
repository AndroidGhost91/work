When(/^I enter unsafe html into "(.*?)"$/) do |selector|
  @html_form_page.enter_unsafe_html(selector)
end

When(/^I submit the html form$/) do
  @html_form_page.submit!
end

Then(/^only safe content should be in "(.*?)"$/) do |html_selector|
  @html_form_page.should_sanitize_within(html_selector)
end

Then(/^only safe content should be included in post response$/) do
  topic = Forem::Topic.last
  visit forem.forum_topic_path(topic, forum_id: topic.forum.slug, format: :json)

  json_response = JSON.parse(page.body)
  @html_form_page.should_sanitize_response(json_response['posts'].last['text'])
end
