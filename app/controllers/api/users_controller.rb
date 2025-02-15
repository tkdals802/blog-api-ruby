class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create, :destroy, :update, :login ]
  skip_before_action :authorized, only: [ :create, :login ]

  # Get /users
  def index
    @users = User.all
    render json: @users
  end

  # Get /users/:user_id
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # POST /users/login
  def login
    @user = User.find_by(username: params[:user][:username])

    if @user.nil?
      render json: { error: "User not found" }, status: 404
    else
      if @user.authenticate(params[:user][:password])# password hashing(bcrypt)
        @token = encode_token({ user_id: @user.id }) #make jwt_token
        render json: {
          message: "Login successful",
          user: @user,
          token: @token
        }, status: 200
      else
        render json: { error: "Invalid password" }, status: 401
      end
    end
  end

  # Post /users
  def create
    # param = :username, :password, :password_confirmation
    @user = User.new(user_params)
    @token = encode_token(user_id: @user.id) #make jwt_token

    if @user.save
      render json: {
        message: "User created successfully",
        user: @user,
        token: @token
      }, status: 201
    else
      render json: { error: "Unable to create User" }, status: 400
    end
  end

  # Put /users
  def update
    # user_params = :username, :password, :password_confirmation
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: { message: "User successfully updated." }, status: 200
    else
      render json: { error: "Unable to update User" }, status: 400
    end
  end

  # Delete /Users/id
  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: { message: "User successfully deleted." }, status: 200
    else
      render json: { error: "Unable to delete User." }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
