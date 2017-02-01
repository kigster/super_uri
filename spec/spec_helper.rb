require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'super_uri'
require 'rspec/its'

require 'support/shared_examples_for_uri'

module SuperURI
  module RSpec
    # Returns root folder for this gem's sources
    def self.gem_root
      File.expand_path('../', File.basename(__FILE__))
    end

    def self.relative_path(absolute)
      absolute.gsub(%r[#{URI::IO.gem_root}/lib/(.*)\.rb], '\1')
    end

    PROJECT_ROOT = self.gem_root + '/spec'
    FILE_PATH    = "#{PROJECT_ROOT}/fixtures/data.json"
    FILE_CONTENT = ::File.read(FILE_PATH)
  end
end

