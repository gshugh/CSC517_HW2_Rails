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

How To:

    All of these instructions assume that you are starting from the landing page.
    All of these instructions assume that your user role allows you to perform these functions.
    Some of these instructions have alternative ways to accomplish the same task.
    It is not feasible to list all possible ways of accomplishing all possible tasks.
    
    How To Sign Up:
        
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
    
    How To Log In:
    
        Enter your email and password
        Click "Log In"
        
    How To Edit Your User Profile:
    
        Click "Show My Profile"
        Click "Edit Profile"
        Make changes
            Note: Admins are not allowed to edit their email or password
        Click "Update User"
        
    How To Cancel Your Account
    
        Click "Show My Profile"
        Click "Cancel Account"
        Confirm your intention
        
    How To View a List of All Users
    
        Click "Show All Users"
        
    How To Create an Account for Someone Else
    
        Click "Show All Users"
        Click "New User"
        Follow instructions for ~~ How To Sign Up ~~
    
    How To View a List of All Tours
    
        Click "Show All Tours"
        
    How To View All Details / Photos / Reviews for a Tour
    
        Click "Show All Tours"
        Click "Show" next to the tour of interest
        
    How To View a List of All Reviews
        
        Click "Show All Reviews"
    
    How To Delete a User
    
        Click "Show All Users"
        Click "Cancel Account" next to the user of interest
        Confirm intention
        
    How To Delete a Tour
    
        Click "Show All Tours"
        Click "Destroy" next to the tour of interest
        Confirm intention
        
    How to Delete a Review
    
        Click "Show All Reviews"
        Click "Destroy" next to the review of interest
        Confirm intention
        
    # TODO add more "how to" sections

Other Notes:

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