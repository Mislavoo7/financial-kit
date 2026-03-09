class User::AccountsController < User::BaseController
  before_action :set_user
  before_action :clear_params, only: [ :update ]

  def edit; end

  def update
    @user.update(user_params)

    redirect_to user_root_path, notice: t("message.updated")
  end

  def destroy_me
    @user.destroy

    redirect_to root_path, notice: t("message.updated")
  end

  private

  def set_user
    @user = current_user
  end

  def clear_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
  end

  def user_params
    params.require(:user).permit(
      :email, :password,
    )
  end
end
