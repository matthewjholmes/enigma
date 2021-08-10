require 'simplecov'
require 'rspec'
SimpleCov.start do
  add_filter './lib/encrypt'
  add_filter './lib/decrypt'
end

# Add lib files here
require 'date'
require './lib/shift'
require './lib/enigma'
require './lib/cipher'
require './lib/generatable'
