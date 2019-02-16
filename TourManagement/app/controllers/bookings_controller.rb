class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    # We populate bookings AND waitlists so that we can show BOTH in the same table
    # This will be a lot more sane for the user than having to click around
    if params['booking_user_id']
      @bookings = Booking.where(user_id: params['booking_user_id'].to_i)
      @lonely_waitlists = Waitlist.where(user_id: params['booking_user_id'].to_i)
      @page_title = "My Bookings"
    elsif params['listing_user_id']
      # https://guides.rubyonrails.org/active_record_querying.html#joining-tables
      @bookings = Booking.joins(
        "INNER JOIN listings ON listings.tour_id = bookings.tour_id AND listings.user_id = #{params['listing_user_id'].to_i}"
      )
      @lonely_waitlists = Waitlist.joins(
        "INNER JOIN listings ON listings.tour_id = waitlists.tour_id AND listings.user_id = #{params['listing_user_id'].to_i}"
      )
      @page_title = "Bookings for My Tours"
    else
      @bookings = Booking.all
      @lonely_waitlists = Waitlist.all
      @page_title = "All Bookings"
    end
    # But there is a catch
    # If a user has booked & waitlisted on the same tour,
    #   these seats are shown in the same table row
    # So for waitlists made available to the view,
    #   we ONLY want to show those that don't have an associated booking
    @lonely_waitlists.select do |waitlist|
      waitlist.seats_booked_same_user_same_tour.zero?
    end
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
    # We got strategy in params, but not needed (or wanted) by model instantiation
    params_book = booking_params.dup
    params_book.delete(:strategy)
    params_waitlist = booking_params.dup
    params_waitlist.delete(:strategy)

    # Examine booking / waitlisting strategy and do some error checking to reject silly attempts
    # 1 - Book All Seats
    # 2 - Book Available Seats, Waitlist Remaining Seats
    # 3 - Waitlist All Seats
    # http://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#S5
    # https://stackoverflow.com/questions/8252783/passing-error-messages-through-flash
    case strategy
    # 1 - Book All Seats
    when 1
      if num_seats < 1
        flash[:error] = "Cannot book #{num_seats} seats"
      elsif num_seats > num_seats_available
        flash[:error] = "Cannot book #{num_seats} seats (only #{num_seats_available} seats available)"
      else
        @booking = Booking.new(params_book)
      end
    # 2 - Book Available Seats, Waitlist Remaining Seats
    when 2
      if num_seats < 1
        flash[:error] = "Cannot book #{num_seats} seats"
      elsif num_seats <= num_seats_available
        flash[:error] = "No need to waitlist #{num_seats} seats (there are #{num_seats_available} seats available)"
      else
        params_book[:num_seats] = num_seats_available
        params_waitlist[:num_seats] = num_seats - num_seats_available
        @booking = Booking.new(params_book)
        @waitlist = Waitlist.new(params_waitlist)
      end
    # 3 - Waitlist All Seats
    when 3
      if num_seats < 1
        flash[:error] = "Cannot waitlist #{num_seats} seats"
      elsif num_seats <= num_seats_available
        flash[:error] = "No need to waitlist #{num_seats} seats (there are #{num_seats_available} seats available)"
      else
        @waitlist = Waitlist.new(params_waitlist)
      end
    else
      flash[:error] = "Did not recognize book / waitlist strategy # #{strategy}"
    end

    # Attempt to save booking (if there is one) and waitlist (if there is one)
    if flash[:error].blank? && @booking
      booking_saved = @booking.save
    end
    if flash[:error].blank? && @waitlist
      waitlist_saved = @waitlist.save
    end

    # Redirect based on what happened above
    respond_to do |format|
      if @booking && booking_saved
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      elsif @waitlist && waitlist_saved
        format.html { redirect_to @waitlist, notice: 'Waitlist was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        # Failed - going back to the new view - make sure to pass along what tour we're working with
        format.html { redirect_to new_booking_path(tour_id: tour_id) }
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
      params.require(:booking).permit(:num_seats, :user_id, :tour_id, :strategy, :booking_user_id, :listing_user_id)
    end
end
