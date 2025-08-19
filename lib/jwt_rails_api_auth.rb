require "jwt_rails_api_auth/version"
require "jwt_rails_api_auth/configuration"

module JwtRailsApiAuth
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
end
