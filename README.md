# CSC517_HW02
Homework 2 (Ruby on Rails)
Tour Management System

Admin:

    Preconfigured admin username: john@john.com 
    Preconfigured admin password: john_password

Landing Page:

    We assume that the user lands on the landing page, where he/she can then login and accomplish the tasks.
    That is, we assume that the user will never type a URL like ".../photos" into their web browser.
    Every user has the same login page which is also the landing page.
    The user can either login and gain more functionality or they can see only the list of all tours and reviews.
    We are using the same login page to redirect a user to same user dashboard, but this dashboard has been customized to show only the relevant links to the user.

Miscellaneous Notes:

    When you delete your account, the following info gets deleted:
        Your bookings: deleted
        Your review: deleted
        Your listings: deleted (if you're an agent/admin)
        Your bookmarks: deleted
        Your waitlists: deleted
    
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
    
    Waitlist Size:
    
        There is no maximum value for the waitlist size.

User Roles:
    
    Admin:
    
        An admin can do anything an agent can do.
        An admin can do anything a customer can do.
        An admin can do anything a logged-in user can do.
        An admin can do anything a not-logged-in visitor can do.
        An admin can see a list of all users.
        An admin can see a list of all bookings.
        An admin cannot edit their user profile email or password.
    
    Agent:
    
        An agent can do anything a logged-in user can do.
        An agent can do anything a not-logged-in visitor can do.
        An agent can create locations.
        An agent can create tours.
        An agent can see a list of all locations.
        An agent can see a list of their tours.
        An agent can see a list of bookmarks for their tours.
        An agent can see a list of bookings for their tours.
        An agent can see a list of reviews for their tours.
        
    Customer:
    
        A customer can do anything a logged-in user can do.
        A customer can do anything a not-logged-in visitor can do.
        A customer can see a list of their bookmarks.
        A customer can see a list of their reviews.
        A customer can see a list of their bookings.
        
    Logged-In-User:
    
        A logged-in user can do anything a not-logged-in visitor can do.
        A logged-in user can see their user profile.
        A logged-in user can edit their user profile.
    
    Not-Logged-In-Visitor:
    
        Anyone can see a list of all tours.
        Anyone can see a list of all reviews.
        Anyone can sign up for a new account.
        Anyone can log in.

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
        *Included in this view*
        <li>Description</li>
        <li>Price</li>
        <li>Booking Deadline</li>
        <li>Start Date</li>
        <li>End Date</li>
        <li>Agent</li>
        <li>Operator Contact</li>
        <li>Status (In Future / Completed / Cancelled)</li>
        <li># Seats</li>
        <li># Seats Booked</li>
        <li># Seats Available</li>
        <li># Seats Waitlisted</li>
        <li>Itinerary (locations, with starting location first)</li>
        <li>Guests (customers who have booked the tour)</li>
        <li>Photos</li>
        <li>Reviews</li>

    How to list a tour
        
        Click "Show All Tours"
        Click "New Tour"
        Enter details and submit
        
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

How To (REVIEWS):

    How To view a list of all reviews
        
        Click "Show All Reviews"
        
    How to view reviews for tours you have created
    
        Click "Show Review for My Tours"
        
    How to view reviews for a particular tour
        
        See ~~ How to view all details for a particular tour ~~
    
    How to view reviews you have created
    
        Click "Show My Reviews"
               
    How to delete a review
    
        Click "Show All Reviews"
        Click "Delete Review" next to the review of interest

How To (BOOKINGS / WAITLISTS):

    How to show bookings for the tours you have created
    
        Click "Show Bookings for My Tours"

How To (LOCATIONS):
