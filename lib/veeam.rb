require "wrapi"
require File.expand_path('veeam/version', __dir__)
require File.expand_path('veeam/pagination', __dir__)
require File.expand_path('veeam/api', __dir__)
require File.expand_path('veeam/client', __dir__)

module Veeam
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_UA       = "Veeam Ruby API wrapper #{Veeam::VERSION}".freeze
  # default options to remove Accept header from WrAPI
  DEFAULT_OPTIONS  = { headers:{ 'User-Agent': DEFAULT_UA } }
  DEFAULT_PAGINATION = RequestPagination::PagingInfoPager
  # Alias for Veeam::Client.new
  #
  # @return [Veeam::Client]
  def self.client(options = {})
    Veeam::Client.new({
      connection_options: DEFAULT_OPTIONS,
      user_agent: DEFAULT_UA,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  def self.reset
    super
    self.endpoint   = nil
    self.user_agent = DEFAULT_UA
    self.connection_options = DEFAULT_OPTIONS
    self.pagination_class = DEFAULT_PAGINATION
  end
end
