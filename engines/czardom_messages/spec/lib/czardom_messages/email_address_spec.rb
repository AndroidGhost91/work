require "spec_helper"
require "./lib/czardom_messages/email_parser"
require "./lib/czardom_messages/email_address"

module CzardomMessages
  describe EmailAddress do
    let(:email) { 'bob+example.hash@czardom.com' }
    subject { EmailAddress.new(email) }

    context "username" do
      it "gets username without hash" do
        expect(subject.username).to eq('bob')
      end
    end

    context "hash" do
      it "gets hash without username" do
        expect(subject.hash).to eq('example.hash')
      end
    end

    context "domain" do
      it "gets domain" do
        expect(subject.domain).to eq('czardom.com')
      end
    end

    context "valid_domain?" do
      it "checks for valid domain" do
        expect(subject.valid_domain?).to be_truthy
      end

       it "returns false for invalid domain" do
         allow(subject).to receive(:domain) { 'example.com' }
         expect(subject.valid_domain?).to be_falsey
       end
    end

    context "invalid_domain?" do
      it "checks for invalid domain" do
        allow(subject).to receive(:valid_domain?) { false }
        expect(subject.invalid_domain?).to be_truthy
      end
    end

  end
end
