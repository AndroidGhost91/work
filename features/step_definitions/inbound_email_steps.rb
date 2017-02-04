When(/^I send an email to "([^"]*)" from "([^"]*)"$/) do |to_address, from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = 'randomhashhere'

  email['To'] = to_address
  email['ToFull'] = [
    {
      'Email' => to_address,
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  post '/messages/inbound_email', email.to_json
end

When(/^I CC an email to "(.*?)" from "(.*?)"$/) do |to_address, from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = 'randomhashhere'

  email['To'] = 'drmarvin@example.com'
  email['ToFull'] = [
    {
      'Email' => 'drmarvin@example.com',
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]
  email['CcFull'] = [
    {
      'Email' => to_address,
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  post '/messages/inbound_email', email.to_json
end

When(/^I BCC an email to "(.*?)" from "(.*?)"$/) do |to_address, from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = 'randomhashhere'

  email['To'] = 'drmarvin@example.com'
  email['ToFull'] = [
    {
      'Email' => 'drmarvin@example.com',
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]
  email['BccFull'] = [
    {
      'Email' => to_address,
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  post '/messages/inbound_email', email.to_json
end

When(/^I reply to an email to "(.*?)" from "(.*?)"$/) do |to_address, from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = 'randomhashhere'

  email['To'] = to_address
  email['ToFull'] = [
    {
      'Email' => to_address,
      'Name' => '',
      'MailboxHash' => 'randomhashhere'
    }
  ]

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  email['StrippedTextReply'] = 'This is my message reply.'

  post '/messages/inbound_email', email.to_json
end

When(/^I send an email to multiple users from "(.*?)"$/) do |from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = ''

  email['To'] = 'bob@czardom.com, george@czardom.com'
  email['ToFull'] = %w(bob@czardom.com george@czardom.com).map do |to_address|
    {
      'Email' => to_address,
      'Name' => '',
      'MailboxHash' => ''
    }
  end

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  post '/messages/inbound_email', email.to_json
end

When(/^I send an email to multiple users with cc and bcc from "(.*?)"$/) do |from_address|
  email = JSON.parse(File.read('./fixtures/inbound_email/email.json'))
  email['MailboxHash'] = ''

  email['To'] = 'steve@czardom.com'
  email['ToFull'] = [
    {
      'Email' => 'steve@czardom.com',
      'Name' => '',
      'MailboxHash' => ''
    }
  ]

  email['CcFull'] = [
    {
      'Email' => 'bob@czardom.com',
      'Name' => '',
      'MailboxHash' => ''
    }
  ]

  email['BccFull'] = [
    {
      'Email' => 'george@czardom.com',
      'Name' => '',
      'MailboxHash' => ''
    }
  ]

  email['From'] = from_address
  email['FromName'] = ''
  email['FromFull'] = {
    'Email' => from_address,
    'Name' => '',
    'MailboxHash' => ''
  }

  post '/messages/inbound_email', email.to_json
end

Then(/^a conversation should be started for "(.*?)"$/) do |username|
  user = User.find(username)
  conversation = user.mailbox.sentbox.first!

  message = conversation.last_message

  expect(conversation.originator).to eq(user)
  expect(conversation.subject).to eq('This is an inbound message')

  expect(conversation.count_messages).to eq(1)
  expect(message.body).to eq('This <b>is the <i>html</i></b> of my email to you.')
end

Then(/^a conversation should be started for "(.*?)" with the sender email$/) do |username|
  user = User.find(username)
  conversation = user.mailbox.sentbox.first!

  message = conversation.last_message

  expect(conversation.originator).to eq(user)
  expect(conversation.subject).to eq('This is an inbound message')

  expect(conversation.count_messages).to eq(1)
  expect(message.body).to eq("<b>From:</b> the.pope@example.com<br><br>This <b>is the <i>html</i></b> of my email to you.")
end

Then(/^a conversation should be created for "([^"]*)"$/) do |username|
  user = User.find(username)
  conversation = user.mailbox.inbox.first

  expect(conversation.subject).to eq('This is an inbound message')
  expect(conversation.is_participant?(user)).to be_truthy
end

Then(/^a conversation should be started for "(.*?)" with the reply$/) do |username|
  user = User.find(username)
  conversation = user.mailbox.sentbox.first!

  message = conversation.last_message

  expect(conversation.originator).to eq(user)
  expect(conversation.subject).to eq('This is an inbound message')

  expect(conversation.count_messages).to eq(1)
  expect(message.body).to eq('This is my message reply.')
end

Then(/^a conversation should be created for "([^"]*)" with the reply$/) do |username|
  user = User.find(username)
  conversation = user.mailbox.inbox.first

  expect(conversation.subject).to eq('This is an inbound message')
  expect(conversation.is_participant?(user)).to be_truthy
end
