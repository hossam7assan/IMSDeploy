require File.expand_path('../boot', __FILE__)
require 'carrierwave/orm/activerecord'
# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
env_vars = File.join(Rails.root, 'config', 'initializers', 'env_vars')
load('env_vars') if File.exists?(env_vars)

Rails.application.initialize!

# config.action_mailer.delivery_method = :smtp
# ActionMailer::Base.default_content_type = "text/html"

# config.action_mailer.smtp_settings = {
#    address:              'smtp.gmail.com',
#    port:                 587,
#    domain:               'example.com',
#    user_name:            '<username>',
#    password:             '<password>',
#    authentication:       'plain',
#    enable_starttls_auto: true  
# }