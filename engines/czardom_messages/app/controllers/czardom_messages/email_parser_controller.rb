module CzardomMessages
  class EmailParserController < CzardomMessagesController
    skip_before_action :authenticate_user!

    def create
      email_json = JSON.parse(request.body.read)
      email = EmailParser.new(email_json)
      email_body = email.body

      begin
        sender = ::User.find_by!(email: email.from_email)
      rescue ActiveRecord::RecordNotFound 
        sender = ::User.find('mail-agent')
        email_body = "<b>From:</b> #{email.from_email}<br><br>#{email_body}"
      end

      recipients = ::User.where(slug: Array.wrap(email.to_usernames))

      sender.send_message(recipients, email_body, email.subject, false)

      head :ok
    end
  end
end
