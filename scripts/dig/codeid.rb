#!/opt/puppetlabs/puppet/bin/ruby

require 'puppetdb'


client = PuppetDB::Client.new({:server => 'http://localhost:8080'})

reports = client.request(
  '',
  "reports[certname, code_id] { latest_report? = true }"
)


puts reports.data
