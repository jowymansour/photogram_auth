class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find_by(:id => id)
    @photos = @user.photos
  end

  def liked_photos
    @user = current_user
    @photos = current_user.liked_photos
  end

end
