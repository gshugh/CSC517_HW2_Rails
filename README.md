# CSC517_HW02
Homework 2 (Ruby on Rails)
Tour Management System

Admin:

    Preconfigured admin username: john@john.com 
    Preconfigured admin password: john

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
    
    Not-Logged-In-Visitor:
    
        Anyone can see a list of all tours.
        Anyone can see a list of all reviews.
        Anyone can sign up for a new account.
        Anyone can log in.

How To:

    All of these instructions assume that you are starting from the landing page.
    All of these instructions assume that your user role allows you to perform these functions.
    
    How To Sign Up:
        
        Click "Sign up now!"
        Enter a name
        Enter an email (must be [something]@[something].com)
        Enter a password (must be between 6 and 40 characters)
        Click "Agent" if you wish to act as a tour agent
        Click "Customer" if you wish to act as a customer
        Click "Create User"
        
    # TODO add more "how to" sections