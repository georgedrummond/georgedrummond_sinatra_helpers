# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "georgedrummond_sinatra_helpers/version"

Gem::Specification.new do |s|
  s.name        = "georgedrummond_sinatra_helpers"
  s.version     = GeorgedrummondSinatraHelpers::VERSION
  s.authors     = ["George Drummond"]
  s.email       = ["george@accountsapp.com"]
  s.homepage    = ""
  s.summary     = %q{Common helper methods}
  s.description = %q{Some common helper methods I use in my apps}

  s.rubyforge_project = "georgedrummond_sinatra_helpers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
