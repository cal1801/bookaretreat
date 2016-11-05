class SiteSetupsController < ApplicationController
  before_action :set_site_setup, only: [:show, :edit, :update, :destroy]

  # GET /site_setups
  # GET /site_setups.json
  def index
    @site_setups = SiteSetup.all
  end

  # GET /site_setups/1
  # GET /site_setups/1.json
  def show
  end

  # GET /site_setups/new
  def new
    @site_setup = SiteSetup.new
  end

  # GET /site_setups/1/edit
  def edit
  end

  # POST /site_setups
  # POST /site_setups.json
  def create
    @site_setup = SiteSetup.new(site_setup_params)

    respond_to do |format|
      if @site_setup.save
        format.html { redirect_to @site_setup, notice: 'Site setup was successfully created.' }
        format.json { render :show, status: :created, location: @site_setup }
      else
        format.html { render :new }
        format.json { render json: @site_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_setups/1
  # PATCH/PUT /site_setups/1.json
  def update
    respond_to do |format|
      if @site_setup.update(site_setup_params)
        format.html { redirect_to @site_setup, notice: 'Site setup was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_setup }
      else
        format.html { render :edit }
        format.json { render json: @site_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_setups/1
  # DELETE /site_setups/1.json
  def destroy
    @site_setup.destroy
    respond_to do |format|
      format.html { redirect_to site_setups_url, notice: 'Site setup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_setup
      @site_setup = SiteSetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_setup_params
      params.require(:site_setup).permit(:hotel, :group_local_bath, :group_sep_bath, :rustic, :rv)
    end
end
