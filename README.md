# Veeam backup API
[![Version](https://img.shields.io/gem/v/veeam.svg)](https://rubygems.org/gems/veaam)
[![Maintainability](https://api.codeclimate.com/v1/badges/cf41385233dc8059e8e6/maintainability)](https://codeclimate.com/github/jancotanis/veeam/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/cf41385233dc8059e8e6/test_coverage)](https://codeclimate.com/github/jancotanis/veeam/test_coverage)

This is a wrapper for the Veeam Service Provider Console rest API. You can see the API endpoints here https://helpcenter.veeam.com/docs/vac/rest/reference/vspc-rest.html

Currently only the GET requests to get a list of tenants and backup job reports are implemented.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'veeam'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install veeam

## Usage

Before you start making the requests to API provide the client id and client secret and email/password using the configuration wrapping.

```
require 'veeam'

# use do block
Veeam.configure do |config|
  config.endpoint = ENV["VEEAM_API_HOST"]
  config.access_token = ENV["VEEAM_API_KEY"]
  config.page_size = 100
end

# or configure with options hash
@client = Veeam.client({ logger: Logger.new(CLIENT_LOGGER) })

client = Veeam.client
client.login

companies = client.companies
companies.each do |t|
  puts "#{t.name}"
end
```

## Resources
### Authentication
```
# setup configuration
#
client.login
```
|Resource|API endpoint|Description|
|:--|:--|:--|
|.login|uses /api/v3/about to chek if creentials are correct|


### About
Endpoint returns general information about the currently installed version of Veeam Service Provider Console.
```
puts client.about.serverVersion
```

|Resource|API endpoint|
|:--|:--|
|.about|/api/v3/about|

### Companies
Endpoint for companies related requests 
```
companies = client.companies
```

|Resource|API endpoint|
|:--|:--|
|.companies|/api/v3/organizations/companies|
|.company|/api/v3/organizations/companies/{id}|
|TODO other endpoints|...|

### Infrastructure
Get list of backup servers
```
server = client.backup_server(id)

```

|Resource|API endpoint|
|:--|:--|
|.backup_servers|/api/v3/backupServers|
|.backup_server|/api/v3/backupServers/{id}|
|TODO other endpoints|...|

### Alarms
This resource collection represents Veeam Service Provider Console alarms.
```
client.active_alarms.each do |alarm|
  if alarms.alarmTemplateUid.eql? "templateUid>"
    :
  end
end

```

|Resource|API endpoint|
|:--|:--|
|.all_triggered_alarms .active_alarms|/api/v3/alarms/active|
|.triggered_alarm .active_alarm|/api/v3/alarms/active/#{alarm_id}|
|.triggered_alarm_history .alarm_history|/api/v3/alarms/active#{alarm_id}/history|
|.all_alarm_templates .alarm_templates|/api/v3/alarms/templates|
|.alarm_template|/api/v3/alarms/templates/#{template_id}|
|.alarm_status_changes .alarm_template_events|/api/v3/alarms/templates/#{template_id}/events|

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jancotanis/veeam.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
