class CryptidsController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /cryptids
  # GET /cryptids.json
  def index
    @cryptids = Cryptid.all
  end

  # GET /cryptids/1
  # GET /cryptids/1.json
  def show
  end

  # GET /cryptids/new
  def new
    @cryptid = Cryptid.new
  end

  # GET /cryptids/1/edit
  def edit
  end

  # POST /cryptids
  # POST /cryptids.json
  def create
    @cryptid = Cryptid.new(cryptid_params)

    respond_to do |format|
      if @cryptid.save
        format.html { redirect_to @cryptid, notice: 'Cryptid was successfully created.' }
        format.json { render :show, status: :created, location: @cryptid }
      else
        format.html { render :new }
        format.json { render json: @cryptid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptids/1
  # PATCH/PUT /cryptids/1.json
  def update
    respond_to do |format|
      if @cryptid.update(cryptid_params)
        format.html { redirect_to @cryptid, notice: 'Cryptid was successfully updated.' }
        format.json { render :show, status: :ok, location: @cryptid }
      else
        format.html { render :edit }
        format.json { render json: @cryptid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptids/1
  # DELETE /cryptids/1.json
  def destroy
    @cryptid.destroy
    respond_to do |format|
      format.html { redirect_to cryptids_url, notice: 'Cryptid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cryptid
      @cryptid = Cryptid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cryptid_params
      params.require(:cryptid).permit(:email, :password, :password_confirmation)
    end
end
