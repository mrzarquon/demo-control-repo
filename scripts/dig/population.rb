#!/opt/puppetlabs/puppet/bin/ruby

require 'puppetdb'

client = PuppetDB::Client.new({:server => 'http://localhost:8080'})

response = client.request(
  '',
  'resources[resource, count(certname)] {type = "File" and title = "/etc/ntp.conf" group by resource}'
)

#lets sort by descending so we start with the largest population first
dissensus = response.data.sort_by { |k| k[:count]}.reverse

# the largest dissensus becomes the consensus
consensus = dissensus.shift

#{"resource"=>"b46c7e16418bd0ac84df8cd4021398826bd51cdf", "count"=>5}
puts consensus
#{"resource"=>"4f3247ecc0c439c17376a377a4a844d5c64dbe87", "count"=>1}
puts dissensus

#populate consensus
