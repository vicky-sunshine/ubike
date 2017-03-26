require 'rake/testtask'
Dir.glob('./{config,models,controllers}/init.rb').each do |file|
  require file
end

task :default => [:spec]

namespace :db do
  require 'sequel'
  Sequel.extension :migration

  desc 'Run migrations'
  task :migrate do
    puts "Environment: #{ENV['RACK_ENV'] || 'development'}"
    puts 'Migrating to latest'
    Sequel::Migrator.run(DB, 'db/migrations')
  end

  desc 'Perform migration reset (full rollback and migration)'
  task :reset do
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
  end
  desc 'Populate the database with test values'
  task :seed do
    load './db/seeds/accounts.rb'
  end
end

desc 'Run all the tests'
Rake::TestTask.new(name=:spec) do |t|
  t.warning = false
  t.pattern = 'specs/*_spec.rb'
end
