require 'uri'
require 'json'

module Veeam
  # Defines HTTP request methods
  # required attributes format
  module RequestPagination

    class PagingInfoPager
      attr_reader :offset, :limit, :total
      def initialize(page_size)
        @offset = 0
        @limit = page_size
        # we halways have a first page
        @total = @offset + 1
      end
      def page_options
        { limit: @limit, offset: @offset }
      end
      def next_page!(data)
        @offset += @limit
        meta = page_info(data)
        if meta
          @total = meta['total'].to_i 
        end
      end

      def more_pages?
        @offset < @total
      end

      def page_info(body) 
        body['meta']['pagingInfo'] if body['meta'] && body['meta']['pagingInfo'] 
      end

      def self.data(body) 
        body['data'] ? body['data'] : body
      end
    end
  end
end
