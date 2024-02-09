module Veeam
  # Wrapper for the Veeam REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in api docs
  # @see https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    include Veeam::Client::About
    include Veeam::Client::Companies
    include Veeam::Client::Infrastructure
    include Veeam::Client::Alarms

  end
end
