namespace :systematize do
  desc "Migrate the database"
  task :migrate => :environment do
    Systematize::Runner.run do |temp_folder|
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] || "true"
      ActiveRecord::Migrator.migrate(temp_folder)
    end
  end

  desc "Rollback the database (options: STEP=x, VERBOSE=false)"
  task :rollback => :environment do
    Systematize::Runner.run do |temp_folder|
      steps = ENV["STEP"] ? ENV["STEP"].to_i : 1

      ActiveRecord::Migration.verbose = ENV["VERBOSE"] || "true"
      ActiveRecord::Migrator.rollback(temp_folder, steps)
    end
  end

  desc "Rollback all the database"
  task :rollback_all => :environment do
    Systematize::Runner.run do |temp_folder|
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] || "true"
      ActiveRecord::Migrator.migrate(temp_folder, 0)
    end
  end
end