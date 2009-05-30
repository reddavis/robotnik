# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{robotnik}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Red Davis"]
  s.date = %q{2009-04-22}
  s.description = %q{Simple tool to compress/merge css and javascript files.}
  s.email = %q{reddavis@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "README.textile",
    "Rakefile",
    "VERSION.yml",
    "lib/robotnik.rb",
    "test/test_examples/css/first.css",
    "test/test_examples/css/compressed.css",
    "test/test_examples/css/master.css",
    "test/test_examples/css/master_compressed.css",
    "test/test_examples/css/master_un_compressed.css",
    "test/test_examples/css/un_compressed.css",
    "test/test_examples/css/second.css",
    "test/test_examples/css/style.css",
    "test/test_examples/css/to_compress.css",
    "test/test_robotnik.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/reddavis/robotnik}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simple tool to compress/merge css and javascript files.}
  s.test_files = [
    "test/test_robotnik.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
