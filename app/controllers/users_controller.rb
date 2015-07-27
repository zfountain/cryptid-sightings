class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource
  # skip_authorize_resource :only => [:new, :create]
  # GET /users
  # GET /users.json
  def index
    if can? :read, @user
      @users = User.all
    else
      redirect_to "/", notice: "Sorry! That page isn\'t available."
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if can? :read, @user
      user ||= User.new
    else
      redirect_to "/", notice: "Sorry! That page isn\'t available."
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
   authorize! :manage, @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # Allow only admins to assign user roles
    authorize! :assign_roles, @user if params[:user][:assign_roles]

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :image, :first_name, :last_name, :username)
    end
end
