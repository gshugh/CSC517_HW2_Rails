require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  fixtures :bookings, :tours, :users

  describe "GET #index" do
    it "populates an array of bookings" do
      booking = [bookings(:one), bookings(:two)]
      get :index
      expect(assigns(:bookings)).to eq(booking)
    end
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested booking to @booking" do
      booking = bookings(:one)
      get :show, params: { id: booking.id }
      expect(assigns(:booking)).to eq(booking)
    end
    it "renders the :show template" do
      get :show, params: { id: bookings(:one).id }
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "renders the :edit template" do
      get :edit, params: { id: bookings(:one).id }
      expect(response).to render_template :edit
    end
  end

  describe "GET #new" do
    it "assigns a new Booking to @booking"
    it "renders the :new template" do
      get :new, params: { tour_id: tours(:one).id }
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:params) { { booking: {
        num_seats: 2,
        tour_id: tours(:one).id,
        user_id: users(:one).id,
        strategy: 1}}}
    context "with valid attributes" do
      it "saves the new booking in the database" do
        previous_count = Booking.count
        post :create, params: params
        expect(Booking.count).to eq(previous_count+1)
      end
      it "redirects to the booking_url(Booking.last)"
    end

    context "with invalid attributes" do
      it "does not save the new booking in the database" do
        previous_count = Booking.count
        params[:tour_id] = nil
        post :create, params: params
        expect(Booking.count).to eq(previous_count)
      end
      it "re-renders the :new template"
    end
  end

  describe "PATCH/PUT #update" do
    it "updates booking"
    it "redirects to booking_url"
  end

  describe "DELETE #destroy" do
    it "deletes the booking"
    it "redirects to booking_url"
  end

end
=begin
  setup do

    @booking = bookings(:one)
    @tour = tours(:one)
    @user = users(:one)

    # Log in a user (gotta have a logged-in user to associate with any new bookings)
    # But cannot use session helper from outside of the controller
    # https://stackoverflow.com/questions/39465941/how-to-use-session-in-the-test-controller-in-rails-5?rq=1
    # So, this is kind of a hack to fake a logged-in user
    # Mimics params sent when logging in manually on the development application
    post login_path, params: { session: { email: @user.email, password: @user.password } }

  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: {
          num_seats: @booking.num_seats,
          tour_id: @booking.tour_id,
          user_id: @booking.user_id,
          # Add a booking strategy (1 - Book All Seats)
          strategy: 1
      } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { num_seats: @booking.num_seats, tour_id: @booking.tour_id, user_id: @booking.user_id } }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end

end
=end
