# frozen_string_literal: true

require 'uri'
require 'json'

module Veeam
  # Provides functionality for handling paginated API requests.
  # The `RequestPagination` module contains the `PagingInfoPager` class,
  # which manages pagination parameters such as `offset`, `limit`, and `total`.
  #
  # == Usage:
  # This class is designed to be used in conjunction with paginated API endpoints
  # to automatically track pagination state and fetch the next page of results.
  #
  # == Example:
  #   pager = Veeam::RequestPagination::PagingInfoPager.new(100)
  #
  #   loop do
  #     response = client.get('/some_endpoint', pager.page_options)
  #     data = Veeam::RequestPagination::PagingInfoPager.data(response)
  #
  #     puts data
  #
  #     break unless pager.more_pages?
  #     pager.next_page!(response)
  #   end
  module RequestPagination
    # Handles pagination logic for Veeam API responses.
    # This class is used to keep track of paginated requests using offset-based pagination.
    class PagingInfoPager
      # @return [Integer] Current offset (starting point for fetching paginated data)
      attr_reader :offset

      # @return [Integer] Current limit (number of items per page)
      attr_reader :limit

      # @return [Integer] Total number of items (if known)
      attr_reader :total

      # Initializes a new `PagingInfoPager` instance with the specified page size.
      #
      # @param page_size [Integer] The number of items per page
      # @example
      #   pager = Veeam::RequestPagination::PagingInfoPager.new(100)
      def initialize(page_size)
        @offset = 0
        @limit = page_size
        # Assume at least one page exists by default
        @total = @offset + 1
      end

      # Returns the current pagination options (limit and offset).
      #
      # @return [Hash] Pagination parameters for an API request
      # @example
      #   pager.page_options
      #   # => { limit: 100, offset: 0 }
      def page_options
        { limit: @limit, offset: @offset }
      end

      # Updates the pagination offset and total number of items based on the response data.
      #
      # @param data [Hash] The response body containing pagination metadata
      # @example
      #   response = client.get('/some_endpoint', pager.page_options)
      #   pager.next_page!(response)
      def next_page!(data)
        @offset += @limit
        meta = page_info(data)
        @total = meta&.dig('total').to_i
      end

      # Determines if there are more pages to be fetched.
      #
      # @return [Boolean] True if more pages exist, false otherwise
      # @example
      #   loop do
      #     break unless pager.more_pages?
      #   end
      def more_pages?
        @offset < @total
      end

      # Extracts pagination metadata (e.g., total items) from the API response body.
      #
      # @param body [Hash] The API response body
      # @return [Hash, nil] The pagination metadata, or nil if not present
      # @example
      #   pager.page_info(response_body)
      #   # => { 'total' => 1000 }
      def page_info(body)
        body['meta']&.dig('pagingInfo')
      end

      # Extracts the actual data from the API response, falling back to the entire body if necessary.
      #
      # @param body [Hash] The API response body
      # @return [Array, Hash] The data from the response, or the entire body if no 'data' key is found
      # @example
      #   data = Veeam::RequestPagination::PagingInfoPager.data(response_body)
      #   # => [{...}, {...}]
      def self.data(body)
        body['data'] || body
      end
    end
  end
end
