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
    @tour = Tour.new(tour_params)

    # Respond
    respond_to do |format|
      if @tour.save
        # Before responding, create a listing relationship between the new tour and the agent
        # The assumption here is that the current user is an agent
        # If not, they should not have been allowed to create a tour
        # Do not complain if we have a nil current user
        # This could happen during test (when nobody is logged in)
        # Do this after the tour is saved (otherwise the listing is no good)
        if current_user
          new_listing = Listing.new(tour_id: @tour.id, user_id: current_user.id)
          new_listing.save
        end
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
      if @tour.update(tour_params)
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
        :num_seats
      )
    end
end
