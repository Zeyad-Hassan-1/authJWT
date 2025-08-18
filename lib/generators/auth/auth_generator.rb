class AuthGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path("templates", __dir__)

  def modify_gemfile
insert_into_file "Gemfile",  after: /^source ['"].*['"]\n/ do
  <<~RUBY
    gem 'bcrypt', '~> 3.1', '>= 3.1.12'
    gem 'jwt', '~> 2.5'
    gem 'rack-cors'
    gem 'active_model_serializers', '~> 0.10.12'
  RUBY
end

  end

  def add_routes
    route <<~RUBY
    # config/routes.rb
      post '/login', to: 'auth#login'
      post '/signup', to: 'users#create'
      get '/me', to: 'users#me'
      resources :password_resets, only: [:create] do
        collection do
          put '/', to: 'password_resets#update'  # PUT /password_resets
        end
      end
      # Admin routes
      post '/users/:id/make_admin', to: 'users#make_admin'
    RUBY
  end

  def create_auth_files
    template "auth_controller.rb", "app/controllers/auth_controller.rb"
    template "user_serializer.rb", "app/serializers/user_serializer.rb"
    template "users_controller.rb", "app/controllers/users_controller.rb"
    template "password_resets_controller.rb", "app/controllers/password_resets_controller.rb"
    template "user.rb", "app/models/user.rb"
    template "mailers/user_mailer.rb", "app/mailers/user_mailer.rb"
    template "mailers/application_mailer.rb", "app/mailers/application_mailer.rb"
  end

  def modify_application_controller
    inject_into_class "app/controllers/application_controller.rb", "ApplicationController" do
      <<~RUBY
        before_action :authorized

        def encode_token(payload)
          # Add admin status to the payload if user is admin
          payload[:admin] = @user.admin? if @user.is_a?(User)
          JWT.encode(payload, 'hellomars1211') 
        end

        def decoded_token
          header = request.headers['Authorization']
          if header
            token = header.split(" ")[1]
            begin
              JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
            rescue JWT::DecodeError
              nil
            end
          end
        end

        def current_user 
          if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
          end
        end

        def current_admin
          current_user && (current_user.admin? || decoded_token[0]['admin'])
        end

        def authorized
          unless !!current_user
            render json: { message: 'Please log in' }, status: :unauthorized
          end
        end

        def admin_authorized
          unless current_admin
            render json: { message: 'Admin access required' }, status: :forbidden
          end
        end

      RUBY
    end
  end

  def self.next_migration_number(dirname)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def copy_migration
    migration_template "migrations/create_user.rb", "db/migrate/create_users.rb"
  end
end