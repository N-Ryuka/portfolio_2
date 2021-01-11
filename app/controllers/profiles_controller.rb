class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def edit
  end
  
  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user.id), notice: '更新しました'
    else
      flash[:alert] = '編集できませんでした'
      render :edit 
    end
  end
  private

  def set_profile
    @profile = Profile.find_by(user_id: current_user.id)
  end
  # user_id: current_user.id
  def profile_params
    params.require(:profile).permit(:image, :lastname, :firstname, :intro).merge(user_id: current_user.id)
  end

  # .merge(user_id: current_user.id)
end
