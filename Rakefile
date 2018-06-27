require 'rake'
require 'rspec/core/rake_task'
require_relative 'db/config'
require_relative "lib/sunlight_legislators_importer"


desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::MigrationContext.new(ActiveRecord::Migrator.migrations_paths).migrate do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "populate the datebase with sample data"
task "db:populate" do
	SunlightLegislatorsImporter.import("db/data/legislators.csv")
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
