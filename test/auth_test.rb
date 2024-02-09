require 'logger'
require "test_helper"

AUTH_LOGGER = "auth_test.log"
File.delete(AUTH_LOGGER) if File.exist?(AUTH_LOGGER)

describe 'auth' do
  before do
    Veeam.reset
  end
  it "#0 no endpoint" do
    c = Veeam.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises ArgumentError do
      c.login
    end
    Veeam.configure do |config|
      config.endpoint = ENV["VEEAM_API_HOST"]
    end
  end
  it "#1 not logged in/no token" do
    Veeam.configure do |config|
      config.endpoint = ENV["VEEAM_API_HOST"]
    end
    c = Veeam.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises ArgumentError do
      c.login
    end
  end
  it "#2 wrong credentials" do
    Veeam.configure do |config|
      config.endpoint = ENV["VEEAM_API_HOST"]
      config.access_token = 'api-key-token'
    end
    c = Veeam.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises Faraday::UnauthorizedError do
      c.login
    end
  end
  it "#3 logged in" do
    Veeam.configure do |config|
      config.endpoint = ENV["VEEAM_API_HOST"]
      config.access_token = ENV["VEEAM_API_KEY"]
    end
    c = Veeam.client({ logger: Logger.new(AUTH_LOGGER) })

    refute_empty c.login, ".login"
  end
end
