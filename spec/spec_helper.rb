require 'rspec'
require 'data_mapper'
require 'dm-rspec'

require_relative '../lib/calmac_recorder/sailing'

RSpec.configure do |config|
  log_file = File.join(File.dirname(__FILE__), '..', 'log', 'test.log')

  DataMapper::Logger.new(log_file, :debug)
  DataMapper::setup(:default, "postgres://dev@localhost/calmac_recorder_test")
  DataMapper.finalize

  config.before(:each) do
    DataMapper.auto_migrate!
  end

  config.include(DataMapper::Matchers)
end
