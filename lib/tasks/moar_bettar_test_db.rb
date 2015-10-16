# thanks, stackoverflow
# sauce: http://stackoverflow.com/questions/1574797/how-to-load-dbseed-data-into-test-database-automatically
# sauce: http://stackoverflow.com/questions/5916126/how-do-i-prepare-test-databases-for-rails-rspec-tests-without-running-rake-spe

namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:schema:load"].invoke
      Rake::Task["db:seed"].invoke
    end
  end
end
