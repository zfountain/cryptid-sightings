class CryptidsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_action :set_cryptid, only: [:show, :edit, :update, :destroy]

  # GET /cryptids
  # GET /cryptids.json
  # Show data for all cryptids
  def index
    @cryptids = Cryptid.all
    render json: @cryptids.to_json, status: 200
  end

  # GET /cryptids/1
  # GET /cryptids/1.json
  # Show data for one cryptid
  def show
    @cryptid = Cryptid.find(params[:id])
    # render json: @cryptid.to_json, status: 200
  end

  # GET /cryptids/new
  # Displays form for creating a new cryptid
  def new
    @cryptid = Cryptid.new
  end

  # GET /cryptids/1/edit
  # Displays form for editing an existing cryptid
  def edit
  end

  # POST /cryptids
  # POST /cryptids.json
  # Processes data from the new cryptid form and creates a cryptid
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
  # Processes data from the edit cryptid form and updates the cryptid
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
  # Deletes the cryptid
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
      params.require(:cryptid).permit(:name, :content,:image)
    end
end
