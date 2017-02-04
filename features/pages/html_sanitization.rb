class HtmlSanitization
  include Capybara::DSL
  include RSpec::Matchers

  HTML_CONTENT = File.read('./fixtures/unsafe_content.html')

  def enter_unsafe_html(selector)
    fill_in(selector, with: HTML_CONTENT)
  end

  def submit!
    find('input[type=submit]').click
  end

  def should_sanitize_within(html_selector)
    find(html_selector)
    within(html_selector) do
      expect(current_scope.native.children.map(&:name).include?('script')).to be_falsey
      expect_element_to_be_missing('h1')
      expect_element_to_be_missing('h2')
      expect_element_to_be_missing('form')
      expect_element_to_be_missing('input')
      expect_element_to_be_missing('.pull-right')
      expect_element_to_be_missing('[style]')

      expect_element_to_be_found('h3')
    end
  end

  def should_sanitize_response(html)
    expect(html).to eq(Services::HtmlSanitizer.sanitize(HTML_CONTENT).gsub("\n", "\r\n"))
  end

  private

  def expect_element_to_be_missing(selector)
    expect do
      find(selector)
    end.to raise_error(Capybara::ElementNotFound)
  end

  def expect_element_to_be_found(selector)
    find(selector)
  end

end
