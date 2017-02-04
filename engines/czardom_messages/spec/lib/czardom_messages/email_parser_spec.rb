require "spec_helper"
require "./lib/czardom_messages/email_parser"
require "./lib/czardom_messages/email_address"

module CzardomMessages
  describe EmailParser do

    context "from_email" do
      it "gets email address from sender" do
        email = EmailParser.new({ 'From' => 'sender-email' })
        expect(email.from_email).to eq('sender-email')
      end
    end

    context "to_usernames" do
      let(:to_addresses) { %w(bob@czardom.com alice+hash@czardom.com joker@example.com).map { |e| {'Email' => e} } }
      let(:cc_addresses) { %w(fay@czardom.com siggy+hash@czardom.com leo@example.com).map { |e| {'Email' => e} } }
      let(:bcc_addresses) { %w(jennifer@czardom.com john+conversation@czardom.com alice@czardom.com baylor@example.com).map { |e| {'Email' => e} } }

      let(:email_json) do
        {
          'ToFull' => to_addresses,
          'CcFull' => cc_addresses,
          'BccFull' => bcc_addresses
        }
      end

      it "extracts usernames from to, cc and bcc addresses" do
        email = EmailParser.new(email_json)
        expect(email.to_usernames).to eq(%w(bob alice fay siggy jennifer john))
      end
    end

    context "body" do
      it "returns striped reply over html" do
        email = EmailParser.new({ 'StrippedTextReply' => 'text-reply', 'HtmlBody' => 'html-body', 'TextBody' => 'text-body' })
        expect(email.body).to eq('text-reply')
      end

      it "returns html over text" do
        email = EmailParser.new({ 'StrippedTextReply' => '', 'HtmlBody' => 'html-body', 'TextBody' => 'text-body' })
        expect(email.body).to eq('html-body')
      end

      it "falls back to text" do
        email = EmailParser.new({ 'StrippedTextReply' => '', 'HtmlBody' => '', 'TextBody' => 'text-body' })
        expect(email.body).to eq('text-body')
      end
    end

    context "subject" do
      it "gets the subject from the email" do
        email = EmailParser.new({ 'Subject' => 'email-subject' })
        expect(email.subject).to eq('email-subject')
      end
    end

  end
end
