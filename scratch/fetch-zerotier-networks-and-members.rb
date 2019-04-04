require 'net/http'
require 'net/https'
require 'json'
require 'ostruct'
require 'pp'
require 'dotenv/load'

def zerotier_request(endpoint)
  uri = URI(endpoint)

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  authorise_request(req)

  # Fetch Request
  res = http.request(req)

  puts "Response HTTP Status Code: #{res.code}"
  JSON.parse(res.body)
rescue StandardError => e
  puts "HTTP Request failed for #{endpoint} (#{e.message})"
  JSON.parse("{}")
end

def endpoint_get_networks
  'https://my.zerotier.com/api/network'
end

def endpoint_get_network_members(network_id)
  "https://my.zerotier.com/api/network/#{network_id}/member"
end

def authorise_request(req)
  req.add_field "Authorization", "bearer #{ENV['ZEROTIER_API_KEY']}"
end

def get_networks
  zerotier_request(endpoint_get_networks)
end

def get_network_members(network_id)
  zerotier_request(endpoint_get_network_members(network_id))
end

data = {}
networks = get_networks

networks.each do |net|
  data[net['id']] = {
    net: net,
    members_raw: get_network_members(net['id']),
    members: {}
  }
end

data.each_key do |k|
  data[k][:members_raw].each do |m|
    data[k][:members][m['nodeId']] = m
  end
  data[k].delete(:members_raw)
end

# structure tips: data[networkid][:members][nodeid]
#                 data[networkid][:net]

pp data
