class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all 
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('message.deleted')
    else
      redirect_to admin_users_path, alert: t('message.something_wrong')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

