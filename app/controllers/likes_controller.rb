class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def show
    @like = Like.find(params[:id])
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new
    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]
    session[:return_to] = request.referer

    if @like.save
      redirect_to session.delete(:return_to), :notice => "Like created successfully."
    else
      redirect_to session.delete(:return_to), :notice => "Error"
    end
  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like = Like.find(params[:id])

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    if @like.save
      redirect_to "/likes", :notice => "Like updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    session[:return_to] = request.referer
    @like.destroy

    redirect_to session.delete(:return_to), :notice => "Like deleted."
  end
end
