class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]

  # GET /camps
  # GET /camps.json
  def results
    search_location = params[:city] + params[:state]
    addresses = Address.near(search_location, 150).order("distance")
    @camps = Camp.where(address_id: addresses.map(&:id)).sort_by{|c| addresses.map(&:id).index c.address_id}
    @camps.select!{|c| c.site_setup.hotel >= params[:hotel].to_i &&  c.site_setup.group_local_bath >= params[:group_local_bath].to_i &&  c.site_setup.group_sep_bath >= params[:group_sep_bath].to_i &&  c.site_setup.rustic >= params[:rustic].to_i &&  c.site_setup.rv >= params[:rv].to_i}
    addresses = Address.where(id: @camps.map(&:address_id))

    farther_addresses = Address.near(search_location, 300).order("distance")
    @farther_camps = Camp.where('address_id IN (?)', farther_addresses.map(&:id)).sort_by{|c| farther_addresses.map(&:id).index c.address_id} - @camps
    @farther_camps.select!{|c| c.site_setup.hotel >= params[:hotel].to_i &&  c.site_setup.group_local_bath >= params[:group_local_bath].to_i &&  c.site_setup.group_sep_bath >= params[:group_sep_bath].to_i &&  c.site_setup.rustic >= params[:rustic].to_i &&  c.site_setup.rv >= params[:rv].to_i}
    farther_addresses = Address.where(id: @farther_camps.map(&:address_id))

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

  def index
    @camps = Camp.all.order(:name)
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    3.times {@camp.images.build}
  end

  # GET /camps/1/edit
  def edit
    @camp.build_site_setup if @camp.site_setup.blank?
    3.times {@camp.images.build} if @camp.images.blank?
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
      params.require(:camp).permit(:name, :address_id, :contact_id, :web_url, :pccca_member, :site_setup_id, :camp_desc, :camp_url, :staff_desc, :staff_url, images_attributes: [:id, :image_url, :image_type, :camp_id], site_setup_attributes: [:id, :hotel, :group_local_bath, :group_sep_bath, :rustic, :rv])
    end
end
