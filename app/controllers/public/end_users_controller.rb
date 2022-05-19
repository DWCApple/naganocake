class Public::EndUsersController < ApplicationController

  def show
  end

  def edit
    @user = EndUser.find(current_end_user.id)
  end

  def update
    @user = EndUser.find(current_end_user.id)
    @user.update(end_users_params)
    redirect_to end_users_path
  end
  
  def withdrawal
    @user = EndUser.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def end_users_params
    params.require(:end_user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :address, :telephone_number, :postal_code, :email)
  end
end
