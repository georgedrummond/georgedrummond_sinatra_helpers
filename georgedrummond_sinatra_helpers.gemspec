# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "georgedrummond_sinatra_helpers/version"

Gem::Specification.new do |s|
  s.name        = "georgedrummond_sinatra_helpers"
  s.version     = GeorgedrummondSinatraHelpers::VERSION
  s.authors     = ["George Drummond"]
  s.email       = ["george@accountsapp.com"]
  s.homepage    = "https://github.com/georgedrummond/georgedrummond_sinatra_helpers"
  s.description = %q{This is a collection of common helper methods that I use within my Sinatra apps. They have a rails like feel and they mainly fill in for helpers you would find in Rails. They do not behave exactly like their rails counterparts so please be careful to read the RDOC.}
  s.summary     = s.description

  s.extra_rdoc_files = ['README.rdoc', 'LICENSE']
  s.rdoc_options      = %w[--line-numbers --inline-source --title Sinatra --main README.rdoc]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
