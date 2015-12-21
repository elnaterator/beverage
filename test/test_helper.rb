ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'pusher'
require 'minitest/mock'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# delete key, but return resulting hash
class Hash
  def remove k
    delete k
    self
  end
end

# mock pusher trigger for tests
module Pusher
  def self.trigger(channel, event, payload)
    @@last_trigger = {
      channel: channel,
      event: event,
      payload: payload
    }
    Rails.logger.debug "Pusher.trigger invoked : #{@@last_trigger}"
  end
  def self.last_trigger
    @@last_trigger
  end
end