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
    @zombie = Zombie.new
  end

  def edit
    @zombie = Zombie.find(params[:id])
  end

  def create
  	@zombie = Zombie.new(zombie_params)

  	if @zombie.save
  	  redirect_to @zombie
    else
      render 'new'
    end
  end

  def update
    @zombie = Zombie.find(params[:id])

    if @zombie.update(zombie_params)
      redirect_to zombie_path
    else
      render 'edit'
    end
  end

  def destroy
    @zombie = Zombie.find(params[:id])
    @zombie.destroy

    redirect_to zombies_path
  end

private
	def zombie_params
		params.require(:zombie).permit(:name, :graveyard, :longitude, :latitude)
	end
end