module CzardomMessages
  class EmailParser < Struct.new(:email)
    DOMAIN = 'czardom.com'

    def from_email
      email['From']
    end

    def subject
      email['Subject']
    end

    def body
      text_reply = email['StrippedTextReply']
      return text_reply if text_reply.present?

      html_body = email['HtmlBody']
      return html_body if html_body.present?

      email['TextBody']
    end

    def to_usernames
      addresses.map! { |a| EmailAddress.new(a['Email']) }
      addresses.reject(&:invalid_domain?).map(&:username).uniq
    end

    private

    def addresses
      return @addresses if @addresses.present?
      addresses = email.fetch('ToFull', [])
      addresses += email.fetch('CcFull', [])
      addresses += email.fetch('BccFull', [])
      @addresses = addresses
    end

  end
end
