class FriendRequestsController < ApplicationController
  before_action :correct_user_destroy, only: [:destroy]

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = FriendRequest.new
    @friend_request.sender_id = params[:sender_id]
    @friend_request.receiver_id = params[:receiver_id]
    session[:return_to] = request.referer

    if correct_user_new
      if @friend_request.save
        redirect_to session.delete(:return_to), :notice => "Friend request created successfully."
      else
        render 'new'
      end
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    session[:return_to] = request.referer

    redirect_to session.delete(:return_to), :notice => "Friend request deleted."
  end


  private
    def correct_user_new
      if current_user.id != @friend_request.sender_id
        redirect_to(root_url, :notice => "Nice try")
        return false
      end
      return true
    end

    def correct_user_destroy
      friend_request = FriendRequest.find(params[:id])
      redirect_to(root_url, :notice => "Nice try") unless current_user == friend_request.sender
    end
end
