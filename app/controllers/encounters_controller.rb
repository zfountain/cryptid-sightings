class EncountersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_action :set_encounter, only: [:show, :edit, :update, :destroy]

  def index
    @encounters = Encounter.order('created_at DESC')
    @cryptids = Cryptid.all
    render json: @encounters.to_json, status: 200
  end

  def show
    @encounter = Encounter.find(params[:id])
    authorize! :read, @encounter
  end

  def new
    @encounter = Encounter.new
  end

  def edit
    authorize! :manage, @encounter
  end

  def create
    @encounter = current_user.encounters.build(encounter_params)
    respond_to do |format|
      if @encounter.save
        format.html { redirect_to @encounter, notice: 'Encounter was successfully created.' }
        format.json { render :show, status: :created, location: @encounter }
      else
        format.html { render :new }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @encounter.update(encounter_params)
        format.html { redirect_to @encounter, notice: 'You have updated your encounter!' }
        format.json { render :show, status: :ok, location: @encounter }
      else
        format.html { render :edit }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @encounter.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'You have deleted your encounter.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encounter
      @encounter = Encounter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encounter_params
      params.require(:encounter).permit(:title, :content, :image, :city, :state, :country, :cryptid_id, :user_id)
    end
end