# Load the Rails application.
require 'bundler'
require 'json'
require 'rest-client'
require 'dotenv'
require 'mailjet'


require_relative 'application'
Dotenv.load
# Initialize the Rails application.
Rails.application.initialize!
