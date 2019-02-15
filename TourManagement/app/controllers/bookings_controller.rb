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

    # TODO examine not_enough_seats_strategy from the parameters passed in
    # TODO it should be blank (I think I can book all these) or
    # TODO should indicate that we want to book available and waitlist remainder or
    # TODO should indicate that we want to waitlist all seats

    # TODO if blank (book all seats), create new booking
    # TODO if book / waitlist, create new booking AND create new waitlist
    # TODO if waitlist all, only create new waitlist

    # TODO redirect according to what we created
    # TODO booking: booking / booking + waitlist: booking / waitlist: waitlist

    # TODO guard against attempted booking or waitlisting of zero seats

    # TODO check this out for inspiration:
    # TODO raise a similar alarm IF num_seats > available # seats AND
    # TODO we do not have a waitlisting strategy
    # TODO this is how we will tell the user "hey I don't have enough seats"
    # TODO as this message will end up in the flash to be displayed
    #     # Associate the currently logged in user with this review
    #     #   This way, the view is not cluttered with the user (they already know who they are)
    #     # The assumption is that there IS a logged in user
    #     #   If not then this review creation should fail
    #     raise "A review cannot be created if there is no logged-in user" unless current_user
    #     @review = Review.new(review_params.merge(:user_id => current_user.id))


    @booking = Booking.new(booking_params)

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
      # TODO support not_enough_seats_strategy in the NEW booking view
      # TODO it should be blank (I think I can book all these) or
      # TODO should indicate that we want to book available and waitlist remainder or
      # TODO should indicate that we want to waitlist all seats
      params.require(:booking).permit(:num_seats, :user_id, :tour_id, :not_enough_seats_strategy)
    end
end
