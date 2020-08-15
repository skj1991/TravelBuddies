class CitiesController < ApplicationController
    before_action :require_login

    def index
        if params[:q]
            @cities = City.where("name like ?", "%#{params[:q]}%")
            #byebug
        else
            @cities = City.all
        end

    end

    def show
        @city = City.find(params[:id])
    end

    def new 
        @city = City.new
    end

    def create
        @city = City.create(city_params)
        if @city.save
            redirect_to cities_path(@city), :flash => { :success => "City has been succesfully added!"}
        else 
            render :new
        end
    end

    private 

    def city_params
        params.require(:city).permit(:name, :country_id, country_name:[:country])
    end
end
