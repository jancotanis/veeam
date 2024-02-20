require "test_helper"

describe 'pager' do
  before do
    Dotenv.load
    Veeam.configure do |config|
      config.endpoint = ENV["VEEAM_API_HOST"]
      config.access_token = ENV["VEEAM_API_KEY"]
    end
    @client = Veeam.client({ logger: Logger.new(CLIENT_LOGGER) })
  end

  it "#1 GET pager" do
    page_size = 50
    pager = Veeam::RequestPagination::PagingInfoPager.new(page_size)
    assert value(pager.offset).must_equal(0), "start at offset 0"
    assert pager.more_pages?, "should have .more_pages?"
    pager.next_page!({})
    refute pager.more_pages?, "should have .more_pages?"
    assert value(pager.offset).must_equal(50), "next at offset 50"
  end
  it "#2 GET pager count pages" do
    page_size = 10
    total = 35.0
    pages = (total/page_size).ceil

    pager = Veeam::RequestPagination::PagingInfoPager.new(page_size)
    count = 0
    while pager.more_pages? do
      count += 1
      # asumption not to check count/offset
      pager.next_page!(JSON.parse({"meta":{"pagingInfo":{"total":total}}}.to_json))
      options = pager.page_options
      assert value(options[:offset]).must_equal(count*page_size), "check page offset"
    end
    assert value(count).must_equal(pages), "check page numbers"
  end
end
