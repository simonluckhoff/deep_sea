class GearsController < ApplicationController
  before_action :authenticate_user!

  def index
    @gears = Gear.all
  end

  def show
    @gear = Gear.find(params[:id])
    # @booking = Booking.find(params[:id])
  end

  def new
    @gear = Gear.new
  end

  def create
    @gear = Gear.new(gear_params)
    @gear.user = current_user
    if @gear.save
      # redirect_to new_gear_path(@gear)
      redirect_to gear_path(@gear), notice: 'Gear was successfully created.'
    else
      Rails.logger.debug @gear.errors.full_messages
      render :new
    end
  end

  def edit
    @gear = Gear.find(params[:id])
  end

  def update
    @gear = Gear.find(params[:id])
    @gear.update(gear_params)
    redirect_to gear_path(@gear)
  end

  def destroy
    @gear = Gear.find(params[:id])
    @gear.destroy
    redirect_to gears_path, status: :see_other
  end

  private

  def gear_params
    params.require(:gear).permit(:title, :description, :price, :photo)
  end
end
