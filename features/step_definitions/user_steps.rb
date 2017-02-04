Given(/^I have a default list of users$/) do
  @jenn = create(:user, first_name: 'Jennifer', last_name: 'DeMarchi', auto_follow: true, about: 'user-about')
  @john = create(:user, first_name: 'John', last_name: 'DeMarchi', auto_follow: true, about: 'user-about')
  @cass = create(:user, first_name: 'Cassin', last_name: 'Duncan', auto_follow: false, about: 'user-about')
end

Given(/^I have created an active user$/) do
  @user = create(:user, first_name: 'Bob', last_name: 'Wiley', email: 'bob@example.com', password: 'secret123', state: 'active')
end

Given(/^I have created multiple users$/) do
  @bob = User.create!(
    slug: 'bob',
    email: 'bob@example.com',
    password: 'secret123',
    first_name: 'Bob',
    last_name: 'Wiley',
    about: 'about bob wiley',
    work: 'self-employed',
    education: 'harvard'
  )

  @alice = User.create!(
    slug: 'alice',
    email: 'alice@example.com',
    password: 'secret123',
    first_name: 'Alice',
    last_name: 'Marvin',
    about: 'about alice marvin',
    work: 'sales rep',
    education: 'yale'
  )

  @george = User.create!(
    slug: 'george',
    email: 'george@example.com',
    password: 'secret123',
    first_name: 'George',
    last_name: 'Costanza',
    about: 'about george costanza',
    work: 'whatever',
    education: 'nyu'
  )

  @steve = User.create!(
    slug: 'steve',
    email: 'steve@example.com',
    password: 'secret123',
    first_name: 'Steve',
    last_name: 'Jobs',
    about: 'about steve jobs',
    work: 'whatever',
    education: 'lau'
  )
end

Given(/^I have assigned an admin access token$/) do
  @user.update_columns(
    admin: true,
    access_token: ENV.fetch('FACEBOOK_ACCESS_TOKEN')
  )
end
