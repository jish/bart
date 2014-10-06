
desc 'Run tests'
task :test do
  result = system("ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/unit/*")
  exit(result ? 0 : 1)
end

task :ci => [:test]
task :default => [:test]

# This task allows you to hook into the pre-commit gem to run the test suite
# before each commit.
namespace :pre_commit do
  task :ci => [:test]
end
