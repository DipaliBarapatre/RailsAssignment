class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :get_user, only: [:show, :update, :destroy]

  # get all user details
  # GET /api/users 
  def index
  	users = User.all.paginate(:page => params[:page], :per_page => 3)
  	render json: users, status: 200
  end

  # Show user details
  # GET /api/user/:id
  def show
  	render json: @user
  end

  # create new user
  # POST /api/user 
  def create
  	user = User.new(user_params)
  	if user.save
  	  render json: user
  	else
  	  render error: {error: "User is not created", status: 422}
  	end
  end

  # update new user
  # PUT /api/user 
  def update
  	if @user.update_attributes(user_params)
  	  render json: {user: @user, message: "User is updated"}
  	else
  	  render error: {error: "User is not updated", status: 422}
  	end
  end

  # delete user
  # DELETE /api/user/:id
  def destroy
  	if @user.delete
  	  render json: {message: "User is removed from application."}
  	else
  	  render error: {error: "User is not deleted", status: 422}
  	end
  end

  #/api/typeahead/:input
  def typeahead
    @users = User.where("email like ? or first_name like ? or last_name like ? ", "%#{params[:input]}%", "%#{params[:input]}%", "%#{params[:input]}%")
    render json: @users
  end


  private

  def get_user
  	@user = User.find(params[:id])
  end

  def user_params
  	params.require(:user).permit(:email, :first_name, :last_name)
  end
end
