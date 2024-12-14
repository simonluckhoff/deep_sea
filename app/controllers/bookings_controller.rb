class BookingsController < ApplicationController
  before_action :set_gear, only: [:new, :edit, :create, :update]

  def index
    @bookings = Booking.all
    # @bookings = current_user.bookings
    # bookings made 
  end

  def show
    @gear = Gear.find(params[:gear_id])
    @booking = Booking.find(params[:id])
  end

  def new
    @gear = Gear.find(params[:gear_id])
    @booking = @gear.bookings.new
    # @booking = Booking.new
    # @booking = @gear.bookings.new
  end

  # def create
  #   # @booking = @gear.bookings.new(booking_params)
  #   @booking = Booking.new(booking_params)
  #   @booking.gear = @gear
  #   @booking.user = current_user
  #   if @booking.save
  #     redirect_to gear_bookings_url
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def create
  #   @booking = @gear.bookings.new(booking_params)
  #   if @booking.save
  #     redirect_to gear_booking_path(@gear, @booking), notice: 'Booking was successfully created.'
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @gear = Gear.find(params[:gear_id])
    @booking = @gear.bookings.new(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @gear = Gear.find(params[:gear_id])
    @booking = Booking.find(params[:id])
    # @booking = @gear.bookings.new(booking_params)
    # @booking.user = current_user
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  def approve
  end

  def decline
  end

  private

  # def booking_params
  #   params.require(:booking).permit(:start_date, :end_date, :user_id, :gear_id)
  # end

  def set_gear
    @gear = Gear.find(params[:gear_id])
  end

  # def set_gear
  #   @gear = Gear.find(params[:gear_id])
  #   @booking = @gear.bookings.new(booking_params)
  #   @booking.user = current_user
  # end

  def booking_params
    # params.require(:booking).permit(:start_date, :end_date, :user_id)
    params.require(:booking).permit(:start_date, :end_date)
  end
end
