class CampInfosController < ApplicationController
  before_action :set_camp_info, only: [:show, :edit, :update, :destroy]

  # GET /camp_infos
  # GET /camp_infos.json
  def index
    @camp_infos = CampInfo.all
  end

  # GET /camp_infos/1
  # GET /camp_infos/1.json
  def show
  end

  # GET /camp_infos/new
  def new
    @camp_info = CampInfo.new
  end

  # GET /camp_infos/1/edit
  def edit
  end

  # POST /camp_infos
  # POST /camp_infos.json
  def create
    @camp_info = CampInfo.new(camp_info_params)

    respond_to do |format|
      if @camp_info.save
        format.html { redirect_to @camp_info, notice: 'Camp info was successfully created.' }
        format.json { render :show, status: :created, location: @camp_info }
      else
        format.html { render :new }
        format.json { render json: @camp_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camp_infos/1
  # PATCH/PUT /camp_infos/1.json
  def update
    respond_to do |format|
      if @camp_info.update(camp_info_params)
        format.html { redirect_to @camp_info, notice: 'Camp info was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp_info }
      else
        format.html { render :edit }
        format.json { render json: @camp_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_infos/1
  # DELETE /camp_infos/1.json
  def destroy
    @camp_info.destroy
    respond_to do |format|
      format.html { redirect_to camp_infos_url, notice: 'Camp info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp_info
      @camp_info = CampInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_info_params
      params.require(:camp_info).permit(:type_id, :description, :url, :camp_id)
    end
end
