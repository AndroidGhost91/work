Before do
  user = User.new(slug: 'mail-agent', first_name: 'Czardom', last_name: 'Mail Agent', about: "I'm a robot moving emails and messages around for you awesome people!")
  user.save(validate: false)
end

After do
  User.find('mail-agent').destroy
end
