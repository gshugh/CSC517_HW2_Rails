################################################################################
# A booking is the number of seats from a particular tour that is reserved by a
# user.
#
# The number of seats must be a non-negative integer.
# Rubify code.

class Booking < ApplicationRecord

  # Relationships
  belongs_to :user
  belongs_to :tour

  # Validations
  validates :num_seats, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  # Callbacks
  # https://edgeguides.rubyonrails.org/active_record_callbacks.html
  # We do this in the model so that we can act on the destroy of a booking
  # whether it was done through the UI (hit the controller)
  # or more directly (e.g. user was destroyed as thus so were their bookings)
  # https://stackoverflow.com/questions/33890458/difference-between-after-create-after-save-and-after-commit-in-rails-callbacks
  # "With after_commit, your code doesn't run until after the outermost transaction was committed"
  # Still, having trouble with enroll_from_waitlist_as_needed causing commits to happen
  # which causes enroll_from_waitlist_as_needed to be called while things are up in the air
  # which causes commits to happen... nightmare
  # So, use class variable as a very dumb lock
  # https://guides.rubyonrails.org/active_record_callbacks.html#using-if-and-unless-with-a-symbol
  after_commit :enroll_from_waitlist_as_needed, unless: :enroll_lock?

  def enroll_lock?
    @@currently_enrolling ||= false
  end

  # Method to get the number of booked seats for the given tour
  def self.get_booked_seats_for_tour(tour)
    num_booked_seats = 0
    bookings_for_tour = Booking.where(tour_id: tour.id)
    bookings_for_tour.each do |booking|
      num_booked_seats += booking.num_seats
    end
    return num_booked_seats
  end

  # Method to get the number of available seats for the given tour
  def self.get_available_seats_for_tour(tour)
    num_booked_seats = Booking.get_booked_seats_for_tour(tour)
    tour.num_seats - num_booked_seats
  end

  # Method to get the waitlist created by this same user on this same tour
  # If no such waitlist, will return nil and we'll need to respond appropriately later on
  def waitlist_same_user_same_tour
    Waitlist.where(user_id: user_id).find_by(tour_id: tour_id)
  end

  # Method to get the # seats waitlisted by this same user on this same tour
  # If no such waitlist, will return zero
  def seats_waitlisted_same_user_same_tour
    waitlist_same_user_same_tour ? waitlist_same_user_same_tour.num_seats : 0
  end

  # Method to get the name of the user who made this booking
  def user_name
    return User.find(user_id).name
  end

  # Method to enroll people onto a tour from the tour's waitlist
  # It's okay if there is no waitlist, this method determines that
  def enroll_from_waitlist_as_needed

    # Very dumb lock
    @@currently_enrolling = true

    # Get tour that some booking was just destroyed for
    tour = self.tour

    # We can possibly enroll if there are available seats, and waitlisted seats
    if Booking.get_available_seats_for_tour(tour).positive? && Waitlist.get_waitlisted_seats_for_tour(tour).positive?
      # Iterate over all waitlists for this tour
      Waitlist.get_waitlists_for_tour_first_come_first_served(tour).each do |waitlist|

        # Since we are in a loop, re-check some stuff each time
        # Available seats in the tour may have been modified so check that again
        # Waitlist may have been destroyed (but not quite totally 100% gone yet)
        # Honestly I don't understand how a "destroyed" waitlist can be returned
        #   from get_waitlists_for_tour_first_come_first_served,
        #   but I am seeing behavior that makes me pretty sure this is happening
        # Here we have multiple levels of trying to NOT see a waitlist we have destroyed
        if waitlist.num_seats <= Booking.get_available_seats_for_tour(tour)

          # We can book all of these seats
          # We need a booking
          #   If there was a booking already, update it
          #   If there was not a booking already, create it
          # We do not need a waitlist (destroy it)
          associated_booking = waitlist.booking_same_user_same_tour
          if associated_booking
            already_booked = associated_booking.num_seats
            associated_booking.update(
              num_seats: already_booked + waitlist.num_seats
            )
          else
            associated_booking = Booking.new(
              num_seats: waitlist.num_seats,
              user_id: waitlist.user_id,
              tour_id: waitlist.tour_id
            )
          end

          # FIRST destroy the waitlist THEN save the new or updated booking
          # to help protect against seats from a waitlist being added to booking more than once
          waitlist.destroy
          associated_booking.save

        end
      end

    end

    # Very dumb lock
    @@currently_enrolling = false

  end

end
