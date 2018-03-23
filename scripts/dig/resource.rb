#!/opt/puppetlabs/puppet/bin/ruby

require 'puppetdb'

resourcechecksum = ARGV[0]


client = PuppetDB::Client.new({:server => 'http://localhost:8080'})

response = client.request(
  '',
  "resources[] { resource =\"#{resourcechecksum}\"}"
)


response.data.first.each do |k,v|
  if k == 'parameters'
    puts "parameters => "
    v.each do |param, value|
      puts "#{param} => #{value}"
    end
  else
    puts "#{k} => #{v}"
  end
end


certnames = client.request(
  '',
  "nodes [certname] { resources {resource =\"#{resourcechecksum}\"} }"
)

nodes = []

certnames.data.each do |certname|
  nodes << certname['certname']
end

puts "All nodes that share this resource:"
puts nodes
