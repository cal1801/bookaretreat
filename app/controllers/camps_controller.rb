class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]

  # GET /camps
  # GET /camps.json
  def index
    search_location = params[:city] + params[:state]
    addresses = Address.near(search_location, 150).order("distance")
    @camps = Camp.where('address_id IN (?)', addresses.map(&:id)).sort_by{|c| addresses.map(&:id).index c.address_id}

    farther_addresses = Address.near(search_location, 300).order("distance")
    @farther_camps = Camp.where('address_id IN (?)', farther_addresses.map(&:id)).sort_by{|c| farther_addresses.map(&:id).index c.address_id} - @camps

    all_addresses = addresses + farther_addresses
    @hash = Gmaps4rails.build_markers(all_addresses) do |address, marker|
      marker.lat address.lat
      marker.lng address.lon
      marker.json({ id: address.id})
      marker.infowindow "#{(Camp.find_by address_id: address.id).name}"
    end
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    3.times {@camp.images.build}
  end

  # GET /camps/1/edit
  def edit
    3.times {@camp.images.build}
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to camps_url, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_params
      params.require(:camp).permit(:name, :address_id, :contact_id, :web_url, :pccca_member, :site_setup_id, images_attributes: [:image_url, :image_type, :camp_id])
    end
end
