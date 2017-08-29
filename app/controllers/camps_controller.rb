class CampsController < ApplicationController
  #before_action :authenticate_user!, only: [:index, :edit, :update, :destroy]
  before_action :states_var
  before_action :set_camp, only: [:show, :edit, :update, :destroy]
  before_action :fix_state, only: [:search]


  # GET /camps
  # GET /camps.json
  def search
    if params[:city] == ''
      search_by_state
    else
      search_by_address
    end

    @camps.select!{|c| c.site_setup.hotel >= params[:hotel].to_i &&  c.site_setup.group_local_bath >= params[:group_local_bath].to_i &&  c.site_setup.group_sep_bath >= params[:group_sep_bath].to_i &&  c.site_setup.rustic >= params[:rustic].to_i &&  c.site_setup.rv >= params[:rv].to_i}

    @hash = Gmaps4rails.build_markers(@all_addresses) do |address, marker|
      marker.lat address.lat
      marker.lng address.lon
      marker.json({ id: address.id})
      camp = address.camp
      marker.infowindow "<a href='/camps/#{camp.id}' class='infowindow-link'>#{camp.name}<br/>#{address.city}, #{address.state}</a>"
    end

    if @hash.empty?
      latlon = Geocoder.coordinates(params[:state])
      temp = {lat: latlon[0], lng: latlon[1], id: 0, :infowindow => "No Camps Found in the Area"}
      @hash << temp
    end
  end

  def search_by_state
    #if the search param is a full state name
    if @states.select{|state, abv| state.upcase == params[:state].upcase}
      state = @states.select{|state, abv| abv.upcase == params[:state].upcase}
      full_state = state.empty? ? params[:state] : state[0][0]
      byebug
      addresses = Address.where(state: params[:state])
      @camps = addresses.map{|a| a.camp}.sort_by{|c| addresses.map(&:id)}
      byebug
      farther_addresses = Address.near(full_state, 300).order("distance")

      farther_addresses.uniq

      @farther_camps = farther_addresses.map{|a| a.camp}.sort_by{|c| farther_addresses.map(&:id)} - @camps

      @all_addresses = addresses + farther_addresses
    elsif @states.select{|state, abv| abv.upcase == params[:state].upcase}
      state = @states.select{|state, abv| abv.upcase == params[:state].upcase}

      addresses = Address.where(state: state.upcase)
      @camps = addresses.map{|a| a.camp}.sort_by{|c| addresses.map(&:id)}

      farther_addresses = Address.near(params[:state], 300).order("distance")

      farther_addresses.uniq

      @farther_camps = farther_addresses.map{|a| a.camp}.sort_by{|c| farther_addresses.map(&:id)} - @camps

      @all_addresses = addresses + farther_addresses
    else
      search_by_address
    end
  end

  def search_by_address
    search = params[:city] + ", " + params[:state]
    addresses = Address.near(search, 150).order("distance")
    @camps = addresses.map{|a| a.camp}.sort_by{|c| addresses.map(&:id)}

    farther_addresses = Address.near(search, 300).order("distance")

    #find camps in the same state. But problem is with "El Paso, Tx"
    words = search.split(/\W+/)
    words.each do |word|
      state = @states.select{|state, abv| state.upcase == word.upcase}
      word = state.empty? ? word : state[0][1]

      Address.where(state: word.upcase).each do |address|
        farther_addresses << address
      end
    end

    farther_addresses.uniq

    @farther_camps = farther_addresses.map{|a| a.camp}.sort_by{|c| farther_addresses.map(&:id)} - @camps

    @all_addresses = addresses + farther_addresses
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
  end

  def index
    @camps = Camp.all.order(:name)
  end

  def all
    @camps = Camp.all.order(:name)
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    3.times {@camp.images.build}
  end

  # GET /camps/1/edit
  def edit
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
    user = User.find_by_email @camp.contact.try(:email)
    if user.nil?
      contact = Contact.create(f_name:"Camp", l_name:"Contact",email:params[:email])
      @camp.update_column("contact_id", contact.id)
      User.create(email:params[:email], password:"pccca_2017")
    else
      user.update_column("email",params[:email])
      @camp.contact.update_column("email",params[:email])
    end
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to edit_camp_path(@camp), notice: 'Camp was successfully updated.' }
        format.json { render :edit, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_membership
    respond_to do |format|
      if @camp.update_column('pccca_member', params[:change_to])
        format.html { render :nothing => true, json: @camp, notice: 'Camp was successfully updated.' }
        format.json { render json: @camp, status: :ok }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.friendly.find(params[:id])
    end

    def fix_state
      state = @states.select{|state, abv| state.upcase == params[:state].upcase}
      params[:state] = state.empty? ? params[:state] : state[0][1]
      #byebug
    end

    def states_var
      @states = [
        ['Alabama', 'AL'],
        ['Alaska', 'AK'],
        ['Arizona', 'AZ'],
        ['Arkansas', 'AR'],
        ['California', 'CA'],
        ['Colorado', 'CO'],
        ['Connecticut', 'CT'],
        ['Delaware', 'DE'],
        ['District of Columbia', 'DC'],
        ['Florida', 'FL'],
        ['Georgia', 'GA'],
        ['Hawaii', 'HI'],
        ['Idaho', 'ID'],
        ['Illinois', 'IL'],
        ['Indiana', 'IN'],
        ['Iowa', 'IA'],
        ['Kansas', 'KS'],
        ['Kentucky', 'KY'],
        ['Louisiana', 'LA'],
        ['Maine', 'ME'],
        ['Maryland', 'MD'],
        ['Massachusetts', 'MA'],
        ['Michigan', 'MI'],
        ['Minnesota', 'MN'],
        ['Mississippi', 'MS'],
        ['Missouri', 'MO'],
        ['Montana', 'MT'],
        ['Nebraska', 'NE'],
        ['Nevada', 'NV'],
        ['New Hampshire', 'NH'],
        ['New Jersey', 'NJ'],
        ['New Mexico', 'NM'],
        ['New York', 'NY'],
        ['North Carolina', 'NC'],
        ['North Dakota', 'ND'],
        ['Ohio', 'OH'],
        ['Oklahoma', 'OK'],
        ['Oregon', 'OR'],
        ['Pennsylvania', 'PA'],
        ['Puerto Rico', 'PR'],
        ['Rhode Island', 'RI'],
        ['South Carolina', 'SC'],
        ['South Dakota', 'SD'],
        ['Tennessee', 'TN'],
        ['Texas', 'TX'],
        ['Utah', 'UT'],
        ['Vermont', 'VT'],
        ['Virginia', 'VA'],
        ['Washington', 'WA'],
        ['West Virginia', 'WV'],
        ['Wisconsin', 'WI'],
        ['Wyoming', 'WY'],
        ['Alberta', 'AB'],
        ['British Columbia', 'BC'],
        ['Manitoba', 'MB'],
        ['New Brunswick', 'NB'],
        ['Newfoundland', 'NL'],
        ['Nova Scotia','NS'],
        ['Northwest Territories','NT'],
        ['Nunavut','NU'],
        ['Ontario','ON'],
        ['Prince Edward Island','PE'],
        ['Quebec','QC'],
        ['Saskatchewan','SK'],
        ['Yukon','YT']
      ]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_params
      params[:camp][:images_attributes].delete_if{|k,v| v[:image_url].nil?} unless params[:camp][:images_attributes].nil?
      params.require(:camp).permit(:name, :contact_id, :web_url, :pccca_member, :site_setup_id, :camp_desc, :camp_url, :staff_desc, :staff_url,
        images_attributes: [:image_url, :image_type, :camp_id],
        address_attributes: [:address, :address2, :city, :state, :zip, :camp_id],
        site_setup_attributes: [:id, :hotel, :group_local_bath, :group_sep_bath, :rustic, :rv]
      )
    end
end
