
desc 'Run all tests'
task :test do
  Rake::Task["test:spec"].invoke
  Rake::Task["test:unit"].invoke
end

task :ci => [:test]
task :default => [:test]

namespace :pre_commit do
  desc "run the tests"
  task :ci => [:test]
end

namespace :test do
  desc 'Run spec tests'
  task :spec do
    result = system("ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/spec/*")
  end

  desc 'Run unit tests'
  task :unit do
    result = system("ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/unit/*")
  end
end

