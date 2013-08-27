require 'rake/testtask'

desc "Perform all tests"
Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.name = "test"
  t.warning = true
  t.verbose = true
  t.test_files = FileList['test/test_*.rb']
end

desc "Perform integration tests"
Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.name = "test:integration"
  t.warning = true
  t.test_files = FileList['test/integration/test_*.rb']
end

task :default => :test
