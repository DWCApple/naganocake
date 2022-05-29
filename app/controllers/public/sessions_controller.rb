# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  protect_from_forgery
  before_action :customer_state, only: [:create]
  before_action :authenticate_end_user!, except: [:top,:about,:index]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected

  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = EndUser.find_by(email: params[:end_user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer.valid_password?(params[:end_user][:password]) && (@customer.is_deleted == true)
      ## 【処理内容3】
      redirect_to new_end_user_registration_path
    end
  end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_end_user
    @user = EndUser.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_end_user_registration
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
end
