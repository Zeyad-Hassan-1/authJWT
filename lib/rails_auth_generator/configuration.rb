module RailsAuthGenerator
  class Configuration
    attr_accessor :jwt_secret,
                  :access_token_expiry,
                  :refresh_token_expiry,
                  :enable_roles

    def initialize
      @jwt_secret = nil
      @access_token_expiry = 15.minutes
      @refresh_token_expiry = 30.days
      @enable_roles = false
    end
  end
end
