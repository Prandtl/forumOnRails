class UsersController < ApplicationController
  def show
    find_user
  end

  def ban
    find_user
    if (current_user.userstatus == 1 && @user.userstatus !=1)
      @user.userstatus = -1
      @user.save
    end
  end
  helper_method :ban

  def unban
    if (current_user.userstatus == 1 && @user.userstatus == 0)
      @user.userstatus = 0
      @user.save
    end
  end
  helper_method :unban

  private

  def find_user
    @user = User.find(params[:id])
  end
end
