class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # TODO test to ensure that there is no way to get to "new" view without a tour being specified

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new

    # Create an empty booking object
    @booking = Booking.new

    # Remember what tour we are working with and make this available to the view
    # This way the view can pass the tour info along in links as needed
    @tour = Tour.find(params['tour_id'])

  end

  # GET /bookings/1/edit
  def edit

    # Remember what tour we are working with and make this available to the view
    # This way the view can pass the tour info along in links / form fields as needed
    # This is to avoid bothering the user to enter the tour
    # TODO will this work directly??
    @tour = @booking.tour

  end

  # POST /bookings
  # POST /bookings.json
  def create

    # Get some basic info we use several places below
    tour_id = booking_params[:tour_id].to_i
    num_seats = booking_params[:num_seats].to_i
    num_seats_available = Booking.get_available_seats_for_tour(Tour.find(tour_id))
    strategy = booking_params[:strategy].to_i

    # Support altered params for booking / waitlisting
    params_book = booking_params.dup
    params_waitlist = booking_params.dup

    # Examine booking / waitlisting strategy and do some error checking to reject silly attempts
    # 1 - Book All Seats
    # 2 - Book Available Seats, Waitlist Remaining Seats
    # 3 - Waitlist All Seats
    # http://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#S5
    case strategy
    # 1 - Book All Seats
    when 1
      if num_seats < 1
        raise "Cannot book #{num_seats} seats"
      elsif num_seats > num_seats_available
        raise "Cannot book #{num_seats} seats (only #{num_seats_available} seats available)"
      else
        @booking = Booking.new(params_book)
        # TODO redirect to new booking if successful
      end
    # 2 - Book Available Seats, Waitlist Remaining Seats
    when 2
      if num_seats < 1
        raise "Cannot book #{num_seats} seats"
      elsif num_seats <= num_seats_available
        raise "No need to waitlist #{num_seats} seats (there are #{num_seats_available} seats available)"
      else
        params_book[:num_seats] = num_seats_available
        params_waitlist[:num_seats] = num_seats - num_seats_available
        @booking = Booking.new(params_book)
        @waitlist = Waitlist.new(params_waitlist)
        # TODO redirect to new booking if successful
      end
    # 3 - Waitlist All Seats
    when 3
      if num_seats < 1
        raise "Cannot waitlist #{num_seats} seats"
      elsif num_seats <= num_seats_available
        raise "No need to waitlist #{num_seats} seats (there are #{num_seats_available} seats available)"
      else
        @waitlist = Waitlist.new(params_waitlist)
        # TODO redirect to new waitlist if successful
      end
    else
      raise "Did not recognize book / waitlist strategy # #{strategy}"
    end

    # TODO alter the code below based on the comments above
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:num_seats, :user_id, :tour_id, :strategy)
    end
end
