module Services
  class HtmlSanitizer

    def self.sanitize(html)
      Sanitize.clean(html, allowed_html) || ''
    end

    def self.format(html)
      html
    end

    private

    def self.allowed_html
      Sanitize::Config::BASIC.deep_merge({
        elements: %w[
          h3 h4 h5 h6 div
        ],
      }) { |key, this_val, other_val| this_val + other_val }
    end
  end
end
