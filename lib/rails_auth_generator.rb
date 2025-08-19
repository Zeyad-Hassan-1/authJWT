require "rails_auth_generator/version"
require "rails_auth_generator/configuration"

module RailsAuthGenerator
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
