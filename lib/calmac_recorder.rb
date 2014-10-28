require 'data_mapper'
require 'dotenv'
Dotenv.load

require_relative 'calmac_recorder/data_scraper'
require_relative 'calmac_recorder/sailing'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'])
DataMapper.finalize
DataMapper.auto_upgrade!
