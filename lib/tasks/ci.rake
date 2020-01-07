# frozen_string_literal: true

unless Rails.env.production?
  require "rspec/core/rake_task"
  require "coveralls/rake/task"
  Coveralls::RakeTask.new
  namespace :ci do
    RSpec::Core::RakeTask.new(:spec) do |t|
      t.pattern = Dir.glob(["spec/models", "spec/controllers"])
    end
    desc "Run all tests and generate a merged coverage report"
    task tests: [:spec, "coveralls:push"]
  end
end
