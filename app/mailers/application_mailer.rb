# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default :from => "info@czardom.com"
  layout 'mailer'
end