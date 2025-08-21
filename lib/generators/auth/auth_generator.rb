class AuthGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path("templates", __dir__)

  def modify_gemfile
    insert_into_file "Gemfile",  after: /^source ['"].*['"]\n/ do
      <<~RUBY
        gem "bcrypt", ">= 3.1.12"
        gem "jwt", ">= 2.5"
        gem "rack-cors", ">= 0"
        gem "active_model_serializers", ">= 0.10.12"
      RUBY
    end
  end

  def modify_application_rb
    insert_into_file "config/application.rb", after: "config.api_only = true\n" do
      <<~RUBY
        config.middleware.use ActionDispatch::Cookies
      RUBY
    end

  end

  def add_routes
    route <<~RUBY
      # config/routes.rb
        post '/login', to: 'auth#login'
        post '/refresh', to: 'auth#refresh'
        post '/logout', to: 'auth#logout'
        post '/signup', to: 'users#create'
        get '/me', to: 'users#me'
        resources :password_resets, only: [:create] do
          collection do
            put '/', to: 'password_resets#update'  # PUT /password_resets
          end
        end
    RUBY
  end

  def create_auth_files
    template "controllers/auth_controller.rb", "app/controllers/auth_controller.rb"
    template "serializers/user_serializer.rb", "app/serializers/user_serializer.rb"
    template "controllers/users_controller.rb", "app/controllers/users_controller.rb"
    template "controllers/password_resets_controller.rb", "app/controllers/password_resets_controller.rb"
    template "models/user.rb", "app/models/user.rb"
    template "models/refresh_token.rb", "app/models/refresh_token.rb"
    template "mailers/user_mailer.rb", "app/mailers/user_mailer.rb"
    template "mailers/application_mailer.rb", "app/mailers/application_mailer.rb"
    template "concerns/authenticatable.rb", "app/controllers/concerns/authenticatable.rb"
    template "initializers/jwt_rails_api_auth.rb", "config/initializers/jwt_rails_api_auth.rb"
  end

  def modify_application_controller
    inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
      "  include Authenticatable\n"
    end
  end


  def self.next_migration_number(dirname)
    @prev_migration_nr ||= Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    @prev_migration_nr += 1
    @prev_migration_nr.to_s
  end

  def copy_migration
    migration_template "migrations/create_user.rb", "db/migrate/create_users.rb"
    migration_template "migrations/create_refresh_token.rb", "db/migrate/create_refresh_tokens.rb"
  end

  def enable_cors
    insert_into_file "config/application.rb"do
      <<~RUBY
        Rails.application.config.middleware.insert_before 0, Rack::Cors do
          allow do
            origins "example.com"

            resource "*",
              headers: :any,
              methods: [:get, :post, :put, :patch, :delete, :options, :head]
          end
        end
      RUBY
    end
  end
end