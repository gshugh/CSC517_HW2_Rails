require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  fixtures :locations

  describe "GET #index" do
    it "populates an array of locations" do
      location = [locations(:one), locations(:two)]
      locations
      expect(assigns(:locations)).to eq(location)
    end
    it "renders the :index view" do
      locations
      expect(response).to render_template 'locations/index'
    end
  end

  describe "GET #show" do
    it "assigns the requested location to @location" do
      location = locations(:one)
      get :show, params: { id: location.id }
      expect(assigns(:location)).to eq(location)
    end
    it "renders the :show template" do
      get :show, params: { id: locations(:one).id }
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "renders the :edit template" do
      get :edit, params: { id: locations(:one).id }
      expect(response).to render_template :edit
    end
  end

  describe "GET #new" do
    it "assigns a new Location to @location"
    it "renders the :new template" do
      get :new, params: { tour_id: tours(:one).id }
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:params) { { location: {
        state: "New State",
        country: "USA",
    }}}
    context "with valid attributes" do
      it "saves the new location in the database" do
        previous_count = Location.count
        post :create, params: params
        expect(Location.count).to eq(previous_count+1)
      end
      it "redirects to the location_url(Location.last)"
    end

    context "with invalid attributes" do
      it "does not save the new location in the database" do
        previous_count = Location.count
        params[:tour_id] = nil
        post :create, params: params
        expect(Location.count).to eq(previous_count)
      end
      it "re-renders the :new template"
    end
  end

  describe "PATCH/PUT #update" do
    it "updates location"
    it "redirects to location_url"
  end

  describe "DELETE #destroy" do
    it "deletes the location"
    it "redirects to location_url"
  end

end
