class WaitlistsController < ApplicationController
  before_action :set_waitlist, only: [:show, :edit, :update, :destroy]

  # TODO delete any actions that have no views!

  # GET /waitlists
  # GET /waitlists.json
  def index
    @waitlists = Waitlist.all
  end

  # GET /waitlists/1
  # GET /waitlists/1.json
  def show
  end

  # GET /waitlists/new
  def new
    @waitlist = Waitlist.new
  end

  # GET /waitlists/1/edit
  def edit

    # Remember what tour we are working with and make this available to the view
    # This way the view can pass the tour info along in links / form fields as needed
    # This is to avoid bothering the user to enter the tour
    @tour = @waitlist.tour

  end

  # POST /waitlists
  # POST /waitlists.json
  def create
    @waitlist = Waitlist.new(waitlist_params)

    respond_to do |format|
      if @waitlist.save
        format.html { redirect_to @waitlist, notice: 'Waitlist was successfully created.' }
        format.json { render :show, status: :created, location: @waitlist }
      else
        format.html { render :new }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waitlists/1
  # PATCH/PUT /waitlists/1.json
  def update

    # TODO can we end up here?
    # TODO if so keep it dumb and re-route over to bookings edit?

    respond_to do |format|
      if @waitlist.update(waitlist_params)
        format.html { redirect_to @waitlist, notice: 'Waitlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @waitlist }
      else
        format.html { render :edit }
        format.json { render json: @waitlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waitlists/1
  # DELETE /waitlists/1.json
  def destroy
    @waitlist.destroy
    respond_to do |format|
      format.html { redirect_to waitlists_url, notice: 'Waitlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waitlist
      @waitlist = Waitlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waitlist_params
      params.require(:waitlist).permit(:num_seats, :user_id, :tour_id)
    end
end
