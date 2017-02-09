require 'rspec'
require 'active_record'
require 'systematize'
require 'pry'

DATABASE_SPEC_FILE = 'spec/support/db/test.sqlite3'

RSpec.configure do |config|
  config.color = true
  config.tty = true

  config.before(:suite) {
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: DATABASE_SPEC_FILE,
    )
  }

  config.after(:suite) {
    FileUtils.rm(DATABASE_SPEC_FILE)
    ActiveRecord::Base.connection.close
  }
end