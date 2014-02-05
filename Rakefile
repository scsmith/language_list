require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['test/language_list_test.rb']
  t.verbose = true
end

task :default => :test
