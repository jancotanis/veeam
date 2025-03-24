# frozen_string_literal: true

require 'logger'
require 'test_helper'

CLIENT_LOGGER = 'client_test.log'
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)

describe 'client' do
  before do
    Dotenv.load
    Veeam.configure do |config|
      config.endpoint = ENV['VEEAM_API_HOST']
      config.access_token = ENV['VEEAM_API_KEY']
      config.page_size = 100
    end
    @client = Veeam.client({ logger: Logger.new(CLIENT_LOGGER) })
  end

  it '#1 GET /api/v3/about' do
    about = @client.about
    assert about, '.about info available'
    refute about.serverVersion.empty?, 'about.serverVersion'
    assert _(@client.config[:endpoint]).must_equal(ENV['VEEAM_API_HOST']), 'test config endpoint'
  end
  it '#2 GET /api/v3/organizations/companies' do
    companies = @client.companies

    assert companies.any?, '.any?'
    refute companies.first.name.empty?, '.name.empty?'

    first = companies.first
    company = @client.company(first.instanceUid)
    assert value(company.instanceUid).must_equal first.instanceUid, '.instanceid'
    assert value(company.name).must_equal first.name, '.name'
    Veeam.configure do |config|
      config.page_size = 10
    end
    @client = Veeam.client({ logger: Logger.new(CLIENT_LOGGER) })
    paged_company = @client.companies

    assert value(paged_company.count).must_equal companies.count, '.paged companies same count'
  end
  it '#3 GET /api/v3/infrastructure/backupservers' do
    servers = @client.backup_servers

    assert servers.any?, '.any?'
    refute servers.first.name.empty?, '.name.empty?'

    first = servers.first
    server = @client.backup_server(first.instanceUid)

    assert value(server.instanceUid).must_equal first.instanceUid, '.instanceid'
    assert value(server.name).must_equal first.name, '.name'
    Veeam.configure do |config|
      config.page_size = 10
    end
    @client = Veeam.client({ logger: Logger.new(CLIENT_LOGGER) })
    paged_server = @client.backup_servers

    assert value(paged_server.count).must_equal servers.count, '.paged servers same count'
  end
  it '#3 GET /api/v3/alarms/*' do
    # gett all alarms
    alarms = @client.active_alarms

    # assume there are
    assert alarms.any?, 'alarms.any?'

    # get alarm and template by id and chech if equal
    alarm_id = alarms.first.instanceUid
    refute alarm_id.empty?, '.instanceUid.empty?'
    alarm = @client.active_alarm(alarm_id)
    assert value(alarm.instanceUid).must_equal alarm_id

    template_id = alarms.first.alarmTemplateUid
    refute template_id.empty?, '.alarmTemplateUid.empty?'
    template = @client.alarm_template(template_id)
    assert value(template.instanceUid).must_equal template_id

    # get all templates and check if previous template id is there
    assert value(@client.alarm_templates.select { |t| template_id.eql?(t.instanceUid) }.count).must_equal 1, 'template should be retrieved in list'

    # get all event for a template and chekc if all alarm events have same template id
    events = @client.alarm_template_events(template_id)
    assert events.any?, 'events.any?'
    assert value(@client.alarm_template_events(template_id).select { |a| template_id.eql?(a.alarmTemplateUid) }.count).must_equal events.count, 'template should be retrieved in list'
  end
end
