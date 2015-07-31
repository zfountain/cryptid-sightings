class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  # Request password reset
  # Created when user enters email in the reset password form
  def create
    @user = User.find_by_email(params[:email])

    #Send an email to the user with reset instructions
    @user.deliver_reset_password_instructions! if @user

    # Tell the user instructions have been sent. Does not specify if email exists in DB, so we don't leak info to hackers
    redirect_to(root_path, :notice => 'Password reset instructions have been emailed to you.')
  end

  # Password reset form
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  # Action occurs when user has sent the reset password form
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # Password confirmation validation
    @user.password_confirmation = params[:user][:password_confirmation]

    # Clears temporary token and updates password
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, :notice => 'Your password was successfully updated!')
    else
      render :action => 'edit'
    end
  end
end
