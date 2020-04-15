require "rspec/core/rake_task"

task default: :spec
task test: %i[rubocop spec]

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new
