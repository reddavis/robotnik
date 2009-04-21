require 'rake'
require 'rake/testtask'

begin
  gem 'technicalpickles-jeweler', '>= 0.11.0'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "robotnik"
    s.summary = %Q{Simple tool to compress/merge css and javascript files.}
    s.email = "reddavis@gmail.com"
    s.homepage = "http://github.com/reddavis/robotnik"
    s.description = "Simple tool to compress/merge css and javascript files."
    s.authors = ["Red Davis"]
    s.test_files.exclude 'test/test_examples/robotnik'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler --version '>= 0.11.0'"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = false
end