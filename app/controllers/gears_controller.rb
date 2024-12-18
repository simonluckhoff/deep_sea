class GearsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @gears = Gear.search_by_title_and_description(params[:query])
    else
      @gears = Gear.all
    end
    @fantasy_addresses = [
      "Cape Town, South Africa",
      "Johannesburg, South Africa",
      "Durban, South Africa",
      "Pretoria, South Africa",
      "Port Elizabeth, South Africa",
      "Bloemfontein, South Africa",
      "East London, South Africa",
      "Kimberley, South Africa",
      "Polokwane, South Africa",
      "Pietermaritzburg, South Africa",
      "Nelspruit, South Africa",
      "George, South Africa",
      "Rustenburg, South Africa",
      "Stellenbosch, South Africa",
      "Knysna, South Africa",
      "Hermanus, South Africa",
      "Paarl, South Africa",
      "Franschhoek, South Africa",
      "Plettenberg Bay, South Africa",
      "Mossel Bay, South Africa",
      "Oudtshoorn, South Africa",
      "Langebaan, South Africa",
      "Swellendam, South Africa",
      "Somerset West, South Africa",
      "Robertson, South Africa",
      "Worcester, South Africa",
      "Ceres, South Africa",
      "Malmesbury, South Africa",
      "Atlantis, South Africa",
      "Saldanha, South Africa",
      "Vredenburg, South Africa",
      "Wellington, South Africa",
      "Caledon, South Africa",
      "Tulbagh, South Africa",
      "Cape Town, South Africa",
      "Clanwilliam, South Africa"
    ]
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
