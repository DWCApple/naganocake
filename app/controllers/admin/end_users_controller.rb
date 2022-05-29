class Admin::EndUsersController < ApplicationController
before_action :authenticate_admin!, except: [:top]
  def index
    @end_users = EndUser.page(params[:page]).per(1)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_users_path, notice: "会員情報の更新に成功しました"
    else
      render :edit
    end
  end

  private

  def end_user_params
    params.require(:end_user).permit(:email, :family_name, :family_name_kana, :first_name, :first_name_kana, :address, :telephone_number, :postal_code, :is_deleted, :payment_method)
  end
end
