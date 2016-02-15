class UsersController < ApplicationController
  before_action :find_user, only: [:show, :ban, :unban]
  def show
  end

  def ban
    if (current_user.userstatus == 1 && @user.userstatus !=1)
      @user.userstatus = -1
      @user.save
    end
    redirect_to @user
  end
  helper_method :ban

  def unban
    if (current_user.userstatus == 1 && @user.userstatus == -1)
      @user.userstatus = 0
      @user.save
    end
    redirect_to @user
  end
  helper_method :unban

  private

  def find_user
    @user = User.find(params[:id])
  end
end
