OmniAuth.config.test_mode = true

class OmniauthFacebookResponses

  def self.add_mock(token, hash)
    OmniAuth.config.add_mock(:facebook, {
      uid: '12345',
      credentials: {
        token: token
      },
      info: hash.merge(image: 'http://example.com/avatar.png')
    })
  end

  def self.remove_mock
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  def self.existing_account(uid, hash)
    stub_request('new-token-for-existing-user', {})

    OmniAuth.config.add_mock(:facebook, {
      uid: uid,
      credentials: {
        token: 'new-token-for-existing-user',
        expires_at: 30.days.from_now
      },
      info: hash.merge(image: 'http://example.com/avatar.png')
    })
  end

  def self.missing_email(hash)
    stub_request('facebook-missing-email', {
      'bio' => 'MISSING EMAIL BIO',
      'website' => 'MISSING-EMAIL.CO',
      'location' => { 'name' => 'CITY, STATE' },
      'education' => [
        {type: 'High School', school: { 'name' => 'HS - 101' }},
        {type: 'College', school: { 'name' => 'University' }}
      ]
    })

    add_mock('facebook-missing-email', hash)
  end


  def self.missing_location(hash)
    stub_request('facebook-missing-location', {
      'bio' => 'MISSING LOCATION BIO',
      'website' => 'MISSING-LOCATION.CO',
      'education' => [
        {type: 'High School', school: { 'name' => 'HS - 101' }},
        {type: 'College', school: { 'name' => 'University' }}
      ]
    })

    add_mock('facebook-missing-location', hash)
  end

  def self.missing_education(hash)
    stub_request('facebook-missing-education', {
      'bio' => 'MISSING EDUCATION BIO',
      'website' => 'MISSING-EDUCATION.CO',
      'location' => { 'name' => 'CITY, STATE' }
    })

    add_mock('facebook-missing-education', hash)
  end

  def self.missing_website(hash)
    stub_request('facebook-missing-website', {
      'bio' => 'MISSING WEBSITE BIO',
      'location' => { 'name' => 'CITY, STATE' },
      'education' => [
        {type: 'High School', school: { 'name' => 'HS - 101' }},
        {type: 'College', school: { 'name' => 'University' }}
      ]
    })

    add_mock('facebook-missing-website', hash)
  end


  def self.missing_description(hash)
    stub_request('facebook-missing-description', {
      'website' => 'MISSING-DESCRIPTION.CO',
      'location' => { 'name' => 'CITY, STATE' },
      'education' => [
        {type: 'High School', school: { 'name' => 'HS - 101' }},
        {type: 'College', school: { 'name' => 'University' }}
      ]
    })

    add_mock('facebook-missing-description', hash)
  end

  private

  def self.stub_request(access_token, response_hash)
    WebMock.stub_request(:get, "https://graph.facebook.com/me?access_token=#{access_token}").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1'}).
      to_return(:status => 200, :body => response_hash.to_json, :headers => {})
  end
end
