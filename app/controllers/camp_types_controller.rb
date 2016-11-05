class CampTypesController < ApplicationController
  before_action :set_camp_type, only: [:show, :edit, :update, :destroy]

  # GET /camp_types
  # GET /camp_types.json
  def index
    @camp_types = CampType.all
  end

  # GET /camp_types/1
  # GET /camp_types/1.json
  def show
  end

  # GET /camp_types/new
  def new
    @camp_type = CampType.new
  end

  # GET /camp_types/1/edit
  def edit
  end

  # POST /camp_types
  # POST /camp_types.json
  def create
    @camp_type = CampType.new(camp_type_params)

    respond_to do |format|
      if @camp_type.save
        format.html { redirect_to @camp_type, notice: 'Camp type was successfully created.' }
        format.json { render :show, status: :created, location: @camp_type }
      else
        format.html { render :new }
        format.json { render json: @camp_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camp_types/1
  # PATCH/PUT /camp_types/1.json
  def update
    respond_to do |format|
      if @camp_type.update(camp_type_params)
        format.html { redirect_to @camp_type, notice: 'Camp type was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp_type }
      else
        format.html { render :edit }
        format.json { render json: @camp_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_types/1
  # DELETE /camp_types/1.json
  def destroy
    @camp_type.destroy
    respond_to do |format|
      format.html { redirect_to camp_types_url, notice: 'Camp type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp_type
      @camp_type = CampType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_type_params
      params.require(:camp_type).permit(:name)
    end
end
