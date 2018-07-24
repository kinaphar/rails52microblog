class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
  end

  def edit
    @micropost = current_user.microposts.find_by(id: params[:id])
  end

  def update
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Post updated"
      redirect_to root_path
    else
      flash[:danger] = "Edit failed"
      render root_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
