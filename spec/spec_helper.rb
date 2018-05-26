require 'nexus_cli'
require 'webmock/rspec'

APP_ROOT = File.expand_path('../../', __FILE__)
ENV["NEXUS_CONFIG"] = File.join(APP_ROOT, "spec", "fixtures", "nexus.config")

def app_root_path
  Pathname.new(File.expand_path('../..', __FILE__))
end

def fixtures_path
  app_root_path.join('spec/fixtures')
end
