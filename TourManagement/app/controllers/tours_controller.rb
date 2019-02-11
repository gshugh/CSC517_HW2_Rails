class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show

    # Get all reviews associated with this tour so that the View may show them
    @reviews = Review.where(tour_id: @tour.id)

    # Get all locations associated with this tour so that the View may show them
    @locations = Visit.where(tour_id: @tour.id).map do |matching_visit|
      Location.find(matching_visit.location_id)
    end

  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create

    # Create the tour
    @tour = Tour.new(params_without_locations)

    # Respond
    respond_to do |format|
      if @tour.save

        # Create a listing relationship between the new tour and the agent
        # The assumption here is that the current user is an agent
        # If not, they should not have been allowed to create a tour
        # Do not complain if we have a nil current user
        # This could happen during test (when nobody is logged in)
        # Do this after the tour is saved (otherwise the listing is no good)
        if current_user
          new_listing = Listing.new(tour_id: @tour.id, user_id: current_user.id)
          new_listing.save
        end

        # Create a visits relationship between the new tour and every location
        link_to_locations

        # Actual response
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }

      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    respond_to do |format|
      if @tour.update(params_without_locations)

        # Update visits relationship between the new tour and every location
        link_to_locations

        # Respond
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }

      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(
        :name,
        :description,
        :price_in_cents,
        :deadline,
        :start_date,
        :end_date,
        :operator_contact,
        :status,
        :num_seats,
        # Also permit up to 10 locations in the itinerary
        # Any un-selected locations will still come through
        # (just with a special value that we can use to ignore them later)
        :location1,
        :location2,
        :location3,
        :location4,
        :location5,
        :location6,
        :location7,
        :location8,
        :location9,
        :location10
      )
    end

    # Get a copy of the tour parameters that does NOT include the locations
    # Locations in the itinerary are not stored in the tour itself
    # But rather in explicit relationships
    # This way, if we change the number of possible locations in the tour
    # we do not need to change anything about our models
    def params_without_locations
      return tour_params.except(
        # Locations in the itinerary are not stored in the tour itself
        # But rather in explicit relationships
        # This way, if we change the number of possible locations in the tour
        # we do not need to change anything about our models
        :location1,
        :location2,
        :location3,
        :location4,
        :location5,
        :location6,
        :location7,
        :location8,
        :location9,
        :location10
      )
    end

    # Create / Update relationship between a tour and the locations that it visits
    # The view presents 10 slots for the itinerary
    # Anything the user didn't select will default to a location ID of -1
    def link_to_locations

      # Remove any existing links
      # (this method is used in both create and update)
      Visit.where(tour_id: @tour.id).each(&:destroy)

      # Create new links
      got_start_location = false
      (1..10).each do |i|

        selected_location_id = tour_params["location" + i.to_s].to_i

        next unless selected_location_id.positive?

        new_visits_rel = Visit.new(
          tour_id: @tour.id,
          location_id: selected_location_id
        )
        new_visits_rel.save

        next if got_start_location

        new_start_at_rel = StartAt.new(
          tour_id: @tour.id,
          location_id: selected_location_id
        )
        new_start_at_rel.save
        got_start_location = true

      end

    end

end
