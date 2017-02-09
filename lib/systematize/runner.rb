module Systematize
  class Runner

    DB_FOLDER_PATH              = "#{Dir.pwd}/db"
    DATA_MIGRATIONS_PATH        = "#{DB_FOLDER_PATH}/data"
    STRUCTURE_MIGRATIONS_PATH   = "#{DB_FOLDER_PATH}/migrate"
    TEMP_MIGRATIONS_FOLDER_PATH = "#{DB_FOLDER_PATH}/tmp"

    def self.run(&block)

      # Create temporary folder where all the migrations will be
      FileUtils.mkdir(TEMP_MIGRATIONS_FOLDER_PATH)

      #copy all the files to a temporary folder
      FileUtils.cp_r(Dir.glob("#{STRUCTURE_MIGRATIONS_PATH}/*.rb"), TEMP_MIGRATIONS_FOLDER_PATH)
      FileUtils.cp_r(Dir.glob("#{DATA_MIGRATIONS_PATH}/*.rb"), TEMP_MIGRATIONS_FOLDER_PATH)

      ActiveRecord::Base.transaction do
        yield(TEMP_MIGRATIONS_FOLDER_PATH)
      end

    rescue Exception => e
      raise e

    ensure
      # Remove the temporary folder
      FileUtils.rm_rf(TEMP_MIGRATIONS_FOLDER_PATH)
    end
  end
end