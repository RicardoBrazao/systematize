require 'systematize'

module Systematize
  class Railtie < Rails::Railtie
    railtie_name :systematize

    rake_tasks do
      load 'tasks/migrations.rake'
    end
  end
end