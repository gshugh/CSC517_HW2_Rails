class BookingsController < ApplicationController
  # TODO fix problem in executing this code when we have a waitlist and not a booking
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
    @lonely_waitlists = @lonely_waitlists.select do |waitlist|
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

    # Edit page does double-duty (booking / waitlist)
    populate_instance_variables_booking_waitlist

    # Remember what tour we are working with and make this available to the view
    # This way the view can pass the tour info along in links / form fields as needed
    # This is to avoid bothering the user to enter the tour
    @tour = @booking ? @booking.tour : @waitlist.tour

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

    # TODO test all this again since I refactored

    # Examine booking / waitlisting strategy and do some error checking to reject silly attempts
    if booking_strategy_okay?(strategy, num_seats, num_seats_available)
      # Create booking / waitlist records
      case strategy
      # 1 - Book All Seats
      when 1
        @booking = Booking.new(params_book)
      # 2 - Book Available Seats, Waitlist Remaining Seats
      when 2
        params_book[:num_seats] = num_seats_available
        params_waitlist[:num_seats] = num_seats - num_seats_available
        @booking = Booking.new(params_book)
        @waitlist = Waitlist.new(params_waitlist)
      # 3 - Waitlist All Seats
      when 3
        @waitlist = Waitlist.new(params_waitlist)
      end
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

    # Edit page does double-duty (booking / waitlist)
    populate_instance_variables_booking_waitlist

    # Get some basic info we use several places below
    tour_id = booking_params[:tour_id].to_i
    num_seats_already_booked = @booking ? @booking.num_seats : 0
    num_seats_requested = booking_params[:num_seats].to_i
    num_seats_available = Booking.get_available_seats_for_tour(Tour.find(tour_id)) + num_seats_already_booked
    strategy = booking_params[:strategy].to_i

    # Support altered params for booking / waitlisting
    # We got strategy in params, but not needed (or wanted) by model instantiation
    params_book = booking_params.dup
    params_book.delete(:strategy)
    params_waitlist = booking_params.dup
    params_waitlist.delete(:strategy)

    # Examine booking / waitlisting strategy and do some error checking to reject silly attempts
    if booking_strategy_okay?(strategy, num_seats_requested, num_seats_available)

      # TODO remove debug
      puts "**********************"
      puts strategy

      # Create booking / waitlist records
      case strategy
      # 1 - Book All Seats
      when 1
        # We can book all of these seats
        # We need a booking
        #   If there was a booking already, update it
        #   If there was not a booking already, create it
        # We do not need a waitlist
        #   If there was a waitlist already, destroy it
        if @booking
          @booking.update(params_book)
        else
          # TODO test this path
          @booking = Booking.new(params_book)
        end
        if @waitlist
          @waitlist.destroy
        end
      # 2 - Book Available Seats, Waitlist Remaining Seats
      when 2
        # We can do a split booking / waitlisting
        # We need a booking
        #   If there was a booking already, update it
        #   If there was not a booking already, create it
        # We need a waitlist
        #   If there was a waitlist already, update it
        #   If there was not a waitlist already, create it
        params_book[:num_seats] = num_seats_available
        params_waitlist[:num_seats] = num_seats_requested - num_seats_available
        if @booking
          # TODO test this path
          @booking.update(params_book)
        else
          # TODO test this path
          @booking = Booking.new(params_book)
        end
        if @waitlist
          # TODO test this path
          @waitlist.update(params_waitlist)
        else
          # TODO test this path
          @waitlist = Waitlist.new(params_waitlist)
        end
      # 3 - Waitlist All Seats
      when 3
        # We can waitlist all of these seats
        # We do not need a booking
        #   If there was a booking already, destroy it
        # We need a waitlist
        #   If there was a waitlist already, update it
        #   If there was not a waitlist already, create it
        if @booking
          # TODO test this path
          @booking.destroy
        end
        if @waitlist
          # TODO test this path
          @waitlist.update(params_waitlist)
        else
          # TODO test this path
          @waitlist = Waitlist.new(params_waitlist)
        end
      end
    end

    # Attempt to save booking (if there is one) and waitlist (if there is one)
    if flash[:error].blank? && @booking
      # TODO test this path
      booking_saved = @booking.save
    end
    if flash[:error].blank? && @waitlist
      # TODO test this path
      waitlist_saved = @waitlist.save
    end

    # Redirect based on what happened above
    respond_to do |format|
      if @booking && booking_saved
        # TODO test this path
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :created, location: @booking }
      elsif @waitlist && waitlist_saved
        # TODO test this path
        format.html { redirect_to @waitlist, notice: 'Waitlist was successfully updated.' }
        format.json { render :show, status: :created, location: @booking }
      else
        # TODO test this path
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end

    # TODO test booking number decrease
    # TODO test booking number increase
    # TODO test booking/waitlist number decrease
    # TODO test booking/waitlist number increase
    # TODO test waitlist number decrease
    # TODO test waitlist number increase

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
      params.require(:booking).permit(
        :num_seats,
        :user_id,
        :tour_id,
        :strategy,
        :booking_user_id,
        :listing_user_id,
        :waitlist_override
      )
    end

    # Edit page does double-duty (booking / waitlist)
    # So make sure you know which one you're dealing with
    # Waitlist override will be true if we are editing a "lonely" waitlist
    # Waitlist override will be false if we are editing a booking
    #   (which may or may not have an associated booking)
    def populate_instance_variables_booking_waitlist
      if params['waitlist_override']
        # Waitlist is whatever ID was passed in
        @waitlist = Waitlist.find(params['id'].to_i)
        # No associated booking
        @booking = nil
      else
        # Booking is whatever ID was passed in
        @booking = Booking.find(params['id'].to_i)
        # There may also be an associated waitlist
        @waitlist = @booking.waitlist_same_user_same_tour
      end
    end

    # Examine booking / waitlisting strategy and do some error checking to reject silly attempts
    # 1 - Book All Seats
    # 2 - Book Available Seats, Waitlist Remaining Seats
    # 3 - Waitlist All Seats
    # http://ruby-doc.com/docs/ProgrammingRuby/html/tut_expressions.html#S5
    # https://stackoverflow.com/questions/8252783/passing-error-messages-through-flash
    def booking_strategy_okay?(strategy, num_seats_requested, num_seats_available)
      strategy_okay = false
      case strategy
        # 1 - Book All Seats
      when 1
        if num_seats_requested < 1
          flash[:error] = "Cannot book #{num_seats_requested} seats"
        elsif num_seats_requested > num_seats_available
          flash[:error] = "Cannot book #{num_seats_requested} seats (only #{num_seats_available} seats available)"
        else
          strategy_okay = true
        end
        # 2 - Book Available Seats, Waitlist Remaining Seats
      when 2
        if num_seats_requested < 1
          flash[:error] = "Cannot book #{num_seats_requested} seats"
        elsif num_seats_requested <= num_seats_available
          flash[:error] = "No need to waitlist #{num_seats_requested} seats (there are #{num_seats_available} seats available)"
        else
          strategy_okay = true
        end
        # 3 - Waitlist All Seats
      when 3
        if num_seats_requested < 1
          flash[:error] = "Cannot waitlist #{num_seats_requested} seats"
        elsif num_seats_requested <= num_seats_available
          flash[:error] = "No need to waitlist #{num_seats_requested} seats (there are #{num_seats_available} seats available)"
        else
          strategy_okay = true
        end
      else
        flash[:error] = "Did not recognize book / waitlist strategy # #{strategy}"
      end
      return strategy_okay
    end

end
