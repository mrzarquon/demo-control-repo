#!/opt/puppetlabs/puppet/bin/ruby

require 'puppetdb'

resourcechecksum = ARGV


client = PuppetDB::Client.new({:server => 'http://localhost:8080'})

response = client.request(
  '',
  "inventory[certname] {resource = \"#{resourcechecksum}\" }"
)


puts response.data
