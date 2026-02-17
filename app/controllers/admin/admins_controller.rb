class Admin::AdminsController < Admin::BaseController
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all 
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.password = @admin.password_confirmation = SecureRandom.urlsafe_base64
    @token = Devise.token_generator.generate(Admin, :reset_password_token)
    @admin.reset_password_token = @token.last
    @admin.reset_password_sent_at = Time.now.utc
  #  @admin.invitation_sent_at = DateTime.current
    if @admin.save
  #    AdminMailer.send_invitation(@admin, @token.first).deliver_now
      redirect_to admin_admins_path(@admin), notice: t('message.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      redirect_to admin_admins_path, notice: t('message.updated')
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admin_admins_path, notice: t('message.deleted')
    else
      redirect_to admin_admins_path, alert: t('message.something_wrong')
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :email, :password, :password_confirmation,
    )
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
