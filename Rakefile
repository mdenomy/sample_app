# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require "rspec/core/rake_task"
require File.expand_path('../config/application', __FILE__)
require 'rake'

SampleApp::Application.load_tasks


task :default => 'test:unit'

namespace :test do
  desc "Run all RSpec tests"
  RSpec::Core::RakeTask.new('unit') do |task|
    task.pattern    = "spec/**/*_spec.rb"
    task.rspec_opts = ["--color --format documentation"]
  end

end