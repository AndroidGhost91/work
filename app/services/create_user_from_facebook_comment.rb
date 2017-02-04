module Services
  class CreateUserFromFacebookComment < Struct.new(:from)

    def create_user
      user = User.new({
        slug: "#{first_name} #{last_name}",
        first_name: first_name,
        last_name: last_name,
        uid: id,
        provider: 'facebook',
        password: Devise.friendly_token[0, 20],
        email: email
      })

      user.save(validate: false)
      user
    end

    private

    def email
      "%s@fb-user-id.com" % id
    end

    def id
      from['id']
    end

    def first_name
      name[0]
    end

    def last_name
      name[1]
    end

    def name
      name = from['name'].match(/(.+)\s(.+)$/)

      if name.nil?
        [from['name'], '']
      else
        [name[1], name[2]]
      end
    end

  end
end
