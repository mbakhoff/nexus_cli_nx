# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'nexus_cli/version'

Gem::Specification.new do |s|
  s.name        = "nexus_cli_nx"
  s.version     = NexusCli.version
  s.authors     = ["Märt Bakhoff", "Kyle Allan"]
  s.email       = ["anon@sigil.red"]
  s.homepage    = "https://github.com/mbakhoff/nexus_cli_nx"
  s.summary     = %q{A command-line wrapper for making REST calls to Sonatype Nexus. Fork of nexus_cli without chozo/extlib dependencies.}
  s.description = s.summary
  s.licenses     = ["Apache 2.0"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_dependency 'httpclient', '~> 2.8.0'
  s.add_dependency 'json'
  s.add_dependency 'highline'
  s.add_dependency 'jsonpath'
  s.add_runtime_dependency 'activesupport', '~> 3.2.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'aruba', "= 0.5.0"
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
end
