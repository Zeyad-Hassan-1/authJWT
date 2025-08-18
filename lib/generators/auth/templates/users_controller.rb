class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :admin_authorized, only: [:make_admin]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

# app/controllers/users_controller.rb
    def create 
        user = User.create!(user_params)
        @token = encode_token(user_id: user.id)
        render json: {
            user: UserSerializer.new(user), 
            token: @token
        }, status: :created
    end

  def me 
    render json: current_user, status: :ok
  end

  def make_admin
    user = User.find(params[:id])
    user.update!(admin: true)
    render json: { message: "#{user.username} is now an admin" }, status: :ok
  end

  private

    def user_params 
        params.permit(:username, :password, :bio)
    end

  def handle_invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end