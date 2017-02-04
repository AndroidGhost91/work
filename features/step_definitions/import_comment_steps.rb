Given(/^I have created a facebook forum$/) do
  category = Forem::Category.create(name: 'general-category')

  @forum = Forem::Forum.create!(name: 'facebook-posts',
                                description: 'facebook-posts',
                                category: category)
end

Given(/^I have a post with comments with ids$/) do
  author = create(:user, provider: 'facebook', uid: 10153970269018642)

  @commenters = {
    'brian' => author,
    'laura' => create(:user, first_name: 'Laura', last_name: 'Gordillo', provider: 'facebook', uid: 10154026868975459),
  }

  @topic = @forum.topics.create!({
    user: author,
    subject: 'post-with-comments-and-ids',
    posts_attributes: [
      {
        user: author,
        text: 'Looking for a food writer / personality with knowledge of Paris. Need to assign a "10 best". Any suggestions and contact info appreciated.',
        facebook_post_id: '171303432941423_890791514325941',
        created_at: DateTime.parse('2015-07-19T17:46:19+0000')
      },
      {
        user: @commenters['laura'],
        text: "I have someone perfect for this Brian. What's the best email to reach you?",
        facebook_post_id: '890889160982843',
        created_at: DateTime.parse('2015-07-19T20:42:24+0000')
      },
      {
        user: author,
        text: 'Bhoffman@hoffmanmedia.com',
        facebook_post_id: '890923924312700',
        created_at: DateTime.parse('2015-07-19T21:15:15+0000')
      },
      {
        user: author,
        text: 'Thank you!!!',
        facebook_post_id: '890923954312697',
        created_at: DateTime.parse('2015-07-19T21:15:20+0000')
      }
    ]
  })
end

When(/^I view the post$/) do
  visit forem.forum_topic_path(@topic, forum_id: @forum.slug)
  expect(page).to have_content('Looking for a food writer')

  VCR.use_cassette('fetch_comments_with_ids') do
    @response = post '/board/fetch_facebook_comments', topic_id: @topic.id
  end

  expect(JSON.parse(@response.body)).to eq({
    'new_posts' => 4
  })
end

Then(/^the missing comments should be imported with ids$/) do
  @topic.reload

  expect(@topic.posts.count).to eq(8)

  post_1 = Forem::Post.find_by(facebook_post_id: '890998334305259')
  expect(post_1.user).to eq(User.find_by(provider: 'facebook', uid: '10153208394072851'))
  expect(post_1.text).to eq(%Q{I don't have a contact but gather he is pretty "findable".  He had a big cookbook the end of last year...so publisher's rep if the direct approach does not work: \nhttp://www.davidlebovitz.com/})
  expect(post_1.created_at).to eq(DateTime.parse('2015-07-20T00:44:34+0000'))

  post_2 = Forem::Post.find_by(facebook_post_id: '891035130968246')
  expect(post_2.user).to eq(User.find_by(provider: 'facebook', uid: '952195022196'))
  expect(post_2.text).to eq(%Q{c@charleschen.tv was just in paris for Taste of Paris})
  expect(post_2.created_at).to eq(DateTime.parse('2015-07-20T02:41:00+0000'))

  post_3 = Forem::Post.find_by(facebook_post_id: '891703390901420')
  expect(post_3.user).to eq(User.find_by(provider: 'facebook', uid: '10154026868975459'))
  expect(post_3.text).to eq(%Q{Sent you an email Brian! Thanks!!})
  expect(post_3.created_at).to eq(DateTime.parse('2015-07-21T00:50:18+0000'))

  post_4 = Forem::Post.find_by(facebook_post_id: '891944964210596')
  expect(post_4.user).to eq(User.find_by(provider: 'facebook', uid: '10152275357414327'))
  expect(post_4.text).to eq(%Q{http://chocolateandzucchini.com/contact/})
  expect(post_4.created_at).to eq(DateTime.parse('2015-07-21T10:20:34+0000'))

  visit forem.forum_topic_path(@topic, forum_id: @forum.slug)

  expect(page).to have_content('He had a big cookbook the end of last year...')
  expect(page).to have_content('was just in paris for Taste of Paris')
  expect(page).to have_content('Sent you an email Brian')
  expect(page).to have_content('chocolateandzucchini.com')
end
