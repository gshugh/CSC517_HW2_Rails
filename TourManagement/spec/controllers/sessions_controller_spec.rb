require 'rails_helper'

# GET     '/login',     to: 'sessions#new'
# POST    '/login',     to: 'sessions#create'
# DELETE  '/logout',    to: 'sessions#destroy'

RSpec.describe SessionsController, type: :controller do

  describe "an existing user" do
    it "renders the new session template"
    context "with valid credentials" do
      it "allows the user to log in"
      it "redirects to user"
    end
    context "with invalid credentials" do
      it "rejects the attempt to log in"
      it "flashes 'Invalid email/password combination'"
      it "redirects to root_url"
    end
  end

  describe "a new admin" do
    let(:admin_params) { { user: {
        email: "unique@email.com",
        name:  "Eunice Unique",
        password: "",
        admin:    true,
        agent:    false,
        customer: false
    }}}
    context "with valid attributes" do
      it "saves the new admin in the database" do
        previous_count = User.count
        # post :create, params: params
        # expect(User.count).to eq(previous_count+1)
      end
      it "redirects to user"
    end
    context "with invalid attributes" do
      describe "password shorter than 6 characters" do
        it "does not save the new user in the database" do
          previous_count = User.count
          # params[:tour_id] = nil
          # post :create, params: params
          # expect(Booking.count).to eq(previous_count)
        end
        it "redirects to root_url"
      end
      describe "password longer than 40 characters" do
        it "does not save the new user in the database" do
          previous_count = User.count
          # params[:tour_id] = nil
          # post :create, params: params
          # expect(Booking.count).to eq(previous_count)
        end
        it "redirects to root_url"
      end
      describe "email address wrong format" do
        it "does not save the new user in the database"
        it "redirects to root_url"
      end
      describe "email address already in use" do
        it "does not save the new user in the database"
        it "redirects to root_url"
      end
    end
  end

  describe "logging out" do
    it "logs the user out"
    it "redirects to root_url"
  end

end
