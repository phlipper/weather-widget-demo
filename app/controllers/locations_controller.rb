class LocationsController < ApplicationController
  before_action :check_existing_location, only: %i[create]
  before_action :build_location, only: %i[create]
  before_action :set_location, only: %i[show]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # POST /locations or /locations.json
  def create
    respond_to do |format|
      if @location.save
        format.html do
          redirect_to location_url(@location),
            notice: "Location was successfully created."
        end
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @location.errors, status: :unprocessable_entity
        end
      end
    end
  end

private

  def build_location
    @location = Location.new

    begin
      weather_location = AccuWeather::GetLocationForPostalCode.(
        location_params[:postal_code]
      )
      # fail weather_location.inspect
    rescue AccuWeather::LocationNotFound
      @location.errors.add(:postal_code, "not found")
      return render :new, status: :unprocessable_entity
    end

    @location.accu_weather_key = weather_location.key
    @location.city = weather_location.city
    @location.lat = weather_location.lat
    @location.lng = weather_location.lng
    @location.postal_code = location_params[:postal_code]
    @location.state = weather_location.state
  end

  def check_existing_location
    if Location.exists?(postal_code: location_params[:postal_code])
      return redirect_to location_url(location_params[:postal_code])
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.lookup(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:postal_code)
  end
end
