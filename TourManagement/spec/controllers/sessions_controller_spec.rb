require 'rails_helper'

# GET     '/login',     to: 'sessions#new'
# POST    '/login',     to: 'sessions#create'
# DELETE  '/logout',    to: 'sessions#destroy'

RSpec.describe SessionsController, type: :controller do

  describe "an existing user" do
    it "renders the new session template"
    context "with valid credentials" do
      it "allows the user to log in"
      it "redirects to TBD page"
    end
    context "with invalid credentials" do
      it "rejects the attempt to log in"
      it "redirects to root_url"
    end
  end

  describe "a new user" do
    # let(:params) { { booking: {
    #     num_seats: 2,
    #     tour_id: tours(:one).id,
    #     user_id: users(:one).id,
    #     strategy: 1}}}
    context "with valid attributes" do
      it "saves the new user in the database" do
        previous_count = User.count
        # post :create, params: params
        # expect(User.count).to eq(previous_count+1)
      end
      it "redirects to TBS"
    end

    context "with invalid attributes" do
      describe "password too short" do
        it "does not save the new booking in the database" do
          previous_count = Booking.count
          # params[:tour_id] = nil
          # post :create, params: params
          # expect(Booking.count).to eq(previous_count)
        end
        it "redirects to root_url"
      end
      describe "email address wrong format" do
        it "does not save the new booking in the database"
        it "redirects to root_url"
      end
      describe "user name already in use" do
        it "does not save the new booking in the database"
        it "redirects to root_url"
      end
    end
  end

  describe "logging out" do
    it "deletes the booking"
    it "redirects to root_url"
  end

end
