class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # Get api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # Get api/v1/users:id
  def show
    render json: @user
  end

  # POST api/v1/users
  def create
    @user = User.new(params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/users/:id
  def update
    @user = User.new(params)

    if @user.update(params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/v1/users/:id
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints
  def set_user
    @user = User.find(params[:id])
  end
end
