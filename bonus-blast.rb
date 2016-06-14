#!/usr/bin/env ruby

require 'rest-client'
require 'optparse'
require 'dotenv'

Dotenv.load

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: ./bonus-blast.rb [options]'

  opts.on('--points N', Integer, 'Number of points to blast') do |p|
    options[:points] = p
  end

  opts.on('--to SOMEONE', 'Person to gift') do |p|
    options[:to] = p
  end

  opts.on('--reason STRING', 'Reason for giving, e.g. "lol #wat"') do |r|
    options[:reason] = r
  end

  opts.on('-h', '--help', 'Displays help') do
    puts opts
    exit
  end
end.parse!

unless options[:points] && options[:reason] && options[:to]
  puts 'Please enter --points, --to, and --reason!'
  exit
end

options[:points].times do
  RestClient.post(
    "https://bonus.ly/api/v1/bonuses?access_token=#{ENV['TOKEN']}",
    { reason: "+1 #{options[:to]} #{options[:reason]}" }.to_json,
    content_type: :json,
    accept: :json,
  )
end
