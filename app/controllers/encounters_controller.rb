class EncountersController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_action :set_encounter, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /encounters
  # GET /encounters.json
  def index
    @encounters = Encounter.all
  end

  # GET /encounters/1
  # GET /encounters/1.json
  def show
    @encounter = Encounter.find(params[:id])
    authorize! :read, @encounter
  end

  # GET /encounters/new
  def new
    @encounter = Encounter.new
  end

  # GET /encounters/1/edit
  def edit
  end

  # POST /encounters
  # POST /encounters.json
  def create
    # @encounter = Encounter.new(encounter_params)
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

  # PATCH/PUT /encounters/1
  # PATCH/PUT /encounters/1.json
  def update
    respond_to do |format|
      if @encounter.update(encounter_params)
        format.html { redirect_to @encounter, notice: 'Encounter was successfully updated.' }
        format.json { render :show, status: :ok, location: @encounter }
      else
        format.html { render :edit }
        format.json { render json: @encounter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encounters/1
  # DELETE /encounters/1.json
  def destroy
    @encounter.destroy
    respond_to do |format|
      format.html { redirect_to encounters_url, notice: 'Encounter was successfully destroyed.' }
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
      params.require(:encounter).permit(:title, :content, :image)
    end
end
