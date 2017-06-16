#!/usr/bin/env ruby

# CLI app for currency conversion
# Uses Ruby Money for accuracy
# Uses Fixer.io for exchange data

require 'rest-client'
require 'json'
require 'money'
require 'monetize'

# User input
print "Base - Ex.'USD' => "
base_currency = gets.chomp.upcase
print "Amount - Ex.'13.76' => "
initial_amount = gets.chomp
print "Convert to - Ex.'EUR' => "
convert_to = gets.chomp.upcase

# Fetches API info
url = "http://api.fixer.io/latest?base=#{base_currency}&symbols=#{convert_to}"
response = RestClient.get(url)
parsed = JSON.parse(response)
convert_factor = (parsed['rates'][convert_to])

# Conversion setup and logic
Money.add_rate(base_currency, convert_to, convert_factor)

initial = Monetize.parse("#{base_currency} #{initial_amount}")

final_convert = initial.exchange_to(convert_to)

# Output formatting
puts ''
puts '================='
puts "| #{base_currency} to #{convert_to}"
puts "| #{base_currency}: #{initial}"
puts "| #{convert_to}: #{final_convert}"
puts '================='
puts ''
