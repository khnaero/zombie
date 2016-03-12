class ZombiesController < ApplicationController
  def index
    @zombies = Zombie.all
    @geojson = Array.new

    @zombies.each do |zombie|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [zombie.longitude, zombie.latitude]
        },
        properties: {
          name: zombie.name,
          graveyard: zombie.graveyard,
          # :'marker-color' => '#00607d',
          # :'marker-symbol' => 'circle',
          # :'marker-size' => 'medium'
        }
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
    end
  end

  def show
  	@zombie = Zombie.find(params[:id])
    # respond_to :html, :json
  end

  def new
  end

  def edit
  end

  def create
  	@zombie = Zombie.new(zombie_params)

  	@zombie.save
  	redirect_to @zombie
  end

  def update
  end

  def destroy
  end

private
	def zombie_params
		params.require(:zombie).permit(:name, :graveyard, :longitude, :latitude)
	end
end