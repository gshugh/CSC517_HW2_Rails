class WaitlistsController < ApplicationController
  before_action :set_waitlist, only: [:show, :edit, :update, :destroy]

  # https://stackoverflow.com/questions/1266623/how-do-i-call-a-method-in-application-helper-from-a-view
  include ApplicationHelper

  # You may notice that this controller LACKS some common methods
  # That's because waitlists & bookings are so closely related
  # Often, the user is routed to bookings to get things done
  # This keeps us from having lots of duplicated code

  # GET /waitlists/1
  # GET /waitlists/1.json
  def show
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

    # TODO remove debug
    puts "***************************"
    puts "waitlists#update"
    puts "params"
    puts params
    puts "waitlist_params"
    puts waitlist_params

    # Bookings edit page does double-duty (booking / waitlist)
    @booking, @waitlist = get_booking_and_waitlist_from_params(params)
    update_booking_waitlist(@booking, @waitlist, waitlist_params)

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
      params.require(:waitlist).permit(
        :num_seats,
        :user_id,
        :tour_id,
        :strategy,
        :booking_user_id,
        :listing_user_id,
        :waitlist_override
      )
    end

end
