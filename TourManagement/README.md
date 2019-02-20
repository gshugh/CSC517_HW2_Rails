# CSC517_HW02
Homework 2 (Ruby on Rails)
Tour Management System

Web Application deployment:
https://young-fortress-53892.herokuapp.com/

Admin:

    Preconfigured admin username: john@john.com 
    Preconfigured admin password: john_password

Landing Page:

    The app assumes that all visitors start on the same page, where
    visitors can browse tours or create an account in order to bookmark 
    tours, book tours, etc.
    
    Tacit in that assumptionis that the user will never type a URL like 
    ".../photos" into their web browser.

App Interactions

    Users interact with the app depending on their role. There are currently 
    four roles, each with an increasing ability to perform functions. The 
    four roles are visitors, customers, agents, and admins.
    
    Visitors are users of the system who have not logged into the system. 
    They are limited to browsing tours, browsing reviews, and creating an 
    account.

    Customers are users of the system who have registered with the system (as
    a customer) and have logged into the system. In addition to browsing 
    tours and reviews, customers can bookmark tours of interest, review tours
    that have completed, and book tours.
    
    Agents are users of the system who have registered with the system 
    (as an agent) and have logged into the system. similar to 
    customers except they registered as an agent. Admins is a unique, 
    preconfigured user that can perform all of the tasks that the other users
    can perform.
    
User Roles:
    
    Visitor:
    
        * can see a list of all tours.
        * can see a list of all reviews.
        * can sign up for a new account.

    Logged-In-User:
    
        * can do anything a visitor can do.
        * can see their user profile.
        * an edit their user profile.
    
    Customer:
    
        * can do anything a logged-in user can do.
        * can see a list of their bookmarks.
        * can see a list of their reviews.
        * can see a list of their bookings.
        
    Agent:
    
        * can do anything a logged-in user can do.
        * can create locations.
        * can create tours.
        * can see a list of all locations.
        * can see a list of their tours.
        * can see a list of bookmarks for their tours.
        * can see a list of bookings for their tours.
        * can see a list of reviews for their tours.
        
    Admin:
    
        * can do anything a customer can do, except edit their email or password.
        * can do anything an agent can do, except edit their email or password.
        * can see a list of all users. can see a list of all bookings.
    
How To (Read Me First!):

    All of these instructions assume that you are starting from the landing page.
    All of these instructions assume that your user role allows you to perform these functions.
    Some of these instructions have alternative ways to accomplish the same task.
    It is not feasible to list all possible ways of accomplishing all possible tasks.

How To (USERS):
    
    How to sign up
        
        Click "Sign up now!"
        Enter a name
        Enter an email (must be [something]@[something].com)
        Enter a password (must be between 6 and 40 characters)
        Click "Agent" if you wish to act as a tour agent
        Click "Customer" if you wish to act as a customer
        Click "Create User"
        
        Note: we have chosen to allow a new user to sign up, with one email address, as:
            An agent
            A customer
            Both agent & customer
    
    How to log in
    
        Enter your email and password
        Click "Log In"
        
    How to edit your user profile:
    
        Click "Show My Profile"
        Click "Edit Profile"
        Make changes
            Note: No users are allowed to edit their email or password
        Click "Update User"
        
    How to cancel your account
    
        Click "Show My Profile"
        Click "Cancel Account"
        Confirm your intention
    
    How To cancel another user's account
    
        Click "Show All Users"
        Click "Cancel Account" next to the user of interest
        Confirm intention
        
    How to view a list of all users
    
        Click "Show All Users"
        
    How to create an account for someone else
    
        Click "Show All Users"
        Click "New User"
        Follow instructions for ~~ How To Sign Up ~~

How To (BOOKMARKS):

    How to view a list of all bookmarks
        Click "Show All Bookmarks"

    How to view a list of bookmarks of tours that you created
        Click "Show Bookmarks for My Tours"
        
    How to see which tours you have bookmarked
        Click "Show My Bookmarks"
        
    How to bookmark a tour
        Follow instructions for ~~ How to view all details for a particular tour ~~
        Click "Bookmark"
        Click "Create Bookmark"
        
    How to delete a bookmark
        Click "Show My Bookmarks"
        Click "Delete Bookmark" next to the bookmark of interest
        Confirm your intention

How To (TOURS):

    How to view a list of all tours
        Click "Show All Tours"
        
    How to view a list of tours that you created
        Click "Show My Tours"
        
    How to search tours using filters
        Click "Show All Tours"
        Enter filter criteria under "Filter Results"
        Click "Search"
        
    How to view all details for a particular tour
        Click "Show All Tours"
        Click "Show" next to the tour of interest
        * Included in this view:
        * Description
        * Price
        * Booking Deadline
        * Start Date
        * End Date
        * Agent
        * Operator Contact
        * Status (In Future / Completed / Cancelled)
        * # Seats
        * # Seats Booked
        * # Seats Available
        * # Seats Waitlisted
        * Itinerary (locations, with starting location first)
        * Guests (customers who have booked the tour)
        * Photos
        * Reviews

    How to list a tour
        
        Click "Show All Tours"
        Click "New Tour"
        Enter details in all provided fields
        Click "Create Tour"
        
    How to edit / update a tour
    
        Click "Show All Tours"
        Click "Edit" next to the tour of interest
        Make the desired changes
        Click "Update Tour"
    
    How to cancel a tour
    
        Click "Show All Tours"
        Click "Edit" next to the tour of interest
        Click "Cancelled"
        Click "Update Tour"

    How to delete a tour
    
        Click "Show my tours"
        Click "Delete Tour" next to the tour of interest
        Confirm your intention
        
    How to add pictures to tours
        
        Click "Show All Tours"
        Click "Edit" next to the tour of interest
        Click "Edit Photos"
        Click "New [tour name] Photo"
        Enter a name for the photo
        Choose a file for the photo
        Click "Create Photo"
        
    How to delete pictures from tours
        
        Click "Show All Tours"
        Click "Edit" next to the tour of interest
        Click "Edit Photos"
        Click "Delete Photo" next to the photo of interest
        Confirm your intention

How To (REVIEWS):

    How to create a review
        Click "Show My Reviews"
        Click "New Review"
        Select a tour among those listed (those you have booked and which have ended)
        Enter a subject and content
        Click "Create Review"

    How to view a list of all reviews
        
        Click "Show All Reviews"
        
    How to view reviews for tours you have created
    
        Click "Show Review for My Tours"
        
    How to view reviews you have created
    
        Click "Show My Reviews"
        
    How to view reviews for a particular tour
        
        See ~~ How to view all details for a particular tour ~~
    
    How to edit a review
    
        Click "Show All Reviews"
        Click "Edit" next to the review of interest
        Make the desired changes
        Click "Update Review"

    How to delete a review
    
        Click "Show All Reviews"
        Click "Delete Review" next to the review of interest
        Confirm your intention

How To (BOOKINGS / WAITLISTS):

    How to view all bookings / waitlistings
        
        Click "Show All Bookings"

    How to view bookings / waitlistings for the tours you have created
    
        Click "Show Bookings for My Tours"
        
    How to view bookings / waitlistings that you have created
    
        Click "Show My Bookings"
        
    How to view bookings for a particular tour
        
        See ~~ How to view all details for a particular tour ~~
        
    How to book / waitlist a tour
    
        Click "Show All Tours"
        Click "Book" next to the tour of interest
        Enter the number of seats you wish to book
        Select an option from "Book or waitlist?"
        Click "Create Booking"
        
    How to cancel a booking entirely
    
        Click "Show My Bookings"
        Click "Cancel Booking" next to the booking of interest
        Confirm your intention
    
    How to cancel a few seats from a booking done previously (or otherwise edit a booking)
    
        Click "Show My Bookings"
        Click "Edit Booking" next to the booking of interest
        Make the desired changes
        Click "Update Booking"

How To (LOCATIONS):

    How to view all locations
    
        Click "Show All Locations"
    
    How to edit a location
    
        Click "Show All Locations"
        Click "Edit" next to the location of interest
        Make the desired changes
        Click "Update Location"
    
    How to delete a location
    
        Click "Show All Locations"
        Click "Destroy Location" next to location of interest
        Confirm your intention

Miscellaneous Notes:
            
    Tour Operator Contact Info:
    
        Per Piazza:
            "...we have to create operator with some basic info?"
            "Agent information should be fine."
        This is a good idea and if we were starting over we likely would use agent profile information.
        However we already had a field for adding custom operator contact info when creating a tour.
        We have chosen to retain our custom contact info in the interest of flexibility.
        
    Price Filtering:
    
        Per Piazza:
            "...Is it acceptable to filter just by maximum price?"
            "There are no restrictions on the way you would like to implement any functionality."
        We offer price filtering by maximum price, but not by minimum price.
        This is on the theory that cheaper is always better (all else being equal).
    
    Booking / Waitlisting:
    
        There is no maximum value for the waitlist size.
        
        Instead of forcing the user to go through extra steps when "some, but not enough, seats are available",
        we show the user how many seats are available and allow them to select among the following options:
        "Book All Seats" / "Book Available Seats, Waitlist Remaining Seats" / "Waitlist All Seats".
        If the user selects an inappropriate option given the number of available seats,
        then they are instructed as to what went wrong.
        
        As noted in the requirements, if a customer cancels or reduces a booking, or if a customer cancels their account,
        waitlisted customers are enrolled in applicable tours.

    Locations:
    
        Locations are case sensitive. So, "NC, USA" is treated differently than
        "nc, USA". Be careful when adding a new location.
        
    "Extra" Model:

        Our E/R Diagram can be found at doc/CSC517_HW02_EntityRelationshipDiagram.png
        We have a "start_at" model that we ended up never really using.
        Instead, we find the start location for a tour based on order of records stored in the "visits" model.
        Time did not permit cleaning up this 'extra' code.
        
    "Extra" Views:
    
        We used scaffolding to start our application.
        Many views are created by scaffolding.
        Some of these views are never actually available to the user via a link.
        Most of these 'extra' views are retained:
            for time constraints
            for future development on the application if needed
            
     Record Deletion FAQs:
     
        1. What will happen if admin/agent deletes a tour booked by several people?
        Ans: In this case the following information will be deleted:
             - All their bookmarks for their tour(s)
             - All the bookings for their tour(s)
             - All the reviews for their tour(s)
             - All posted pictures for their tour(s)
             - All waitlists for their tour(s)
             - All the corressponding visits for their tour(s)
             - All the listings for their tour(s)
             
        2. What will happen if a user deletes their account?
        Ans: In this case the following information will be deleted:
             - User's bookings / waitlistings
                - If this frees up tour seats, other customers may be enrolled
                - As noted in ~~ Booking / Waitlisting ~~
             - User's reviews
             - User's tour listings
             - User's bookmarks
        
        3. What happens if the admin deletes their account?     
        Ans: Admin account cannot be deleted.
             
