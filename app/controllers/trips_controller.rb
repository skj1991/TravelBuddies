class TripsController < ApplicationController
  before_action :require_login 

  def index
    find_user    
    @trips = @user.trips.all
  end

  def show
    find_user 
    find_trip
  end

  def new
    set_user
    find_city
    @trip = Trip.new
  end

  def create
    set_user
    find_city    
    @trip = @user.trips.build(trip_params)
    if @trip.save
        redirect_to user_trips_path(@user), :flash => { :success => "Trip successfully added!"}
    else
        render :new
    end
  end

  def edit
    set_user
    find_trip
    if @trip.user != current_user
        redirect_to user_trips_path(@user), :flash => { :error => "Trip belongs to another user. Unable to edit."}
    end
  end

  def update
    set_user
    find_trip
    if @trip.update(trip_params)
        redirect_to user_trips_path(@user), :flash => { :success => "Trip successfully updated!"}
    else
        render :edit
    end
  end

  def five_star
    set_user
  end

  def destroy
    set_user
    find_trip
    @trip.destroy
    redirect_to user_trips_path(@user), :flash => { :success => "Trip has been deleted!"}
  end

  private

  def trip_params
    params.require(:trip).permit(:user_id, :city_id, :rating, :must_visit, :comment, city_attributes:[:city, :country, :country_id])
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def find_city
    @city = City.find_by(id: params[:city_id])
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
  end
end
