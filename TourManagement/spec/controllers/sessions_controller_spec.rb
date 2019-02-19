require 'rails_helper'

# GET     '/login',     to: 'sessions#new'
# POST    '/login',     to: 'sessions#create'
# DELETE  '/logout',    to: 'sessions#destroy'

RSpec.describe SessionsController, type: :controller do
  fixtures :users

  describe "controller" do

# GET     '/login',     to: 'sessions#new'
    describe "a visitor" do
      setup do
        @user = users(:two)
      end
      it "renders the new session view" do
        get :new
        expect(response).to render_template 'sessions/new'
      end
      describe "who has registered" do
        context "with valid credentials" do
          it "can log in and redirect to user" do
            post :create, params: { session: { email: users(:two).email,
                                               password: users(:two).password
            } }
            assert_redirected_to user_url(@user)
          end
        end
        context "with invalid credentials" do
          it "flashes and renders the new session view" do
            post :create, params: { session: { email:    users(:two).email,
                                               password: users(:one).password
            } }
            flash = instance_double("flash").as_null_object
            allow_any_instance_of(SessionsController).to receive(:flash).and_return(flash)
#            follow_redirect!
#            expect(response).to render_template :new
          end
        end
      end
    end

    describe "a new admin" do
      let(:admin_params) { { session: {
          email: "unique@email.com",
          name:  "Eunice Unique",
          password: "123456789",
          admin:    true,
          agent:    false,
          customer: false
      }}}
      context "with valid attributes" do
        it "saves the new admin in the database" do
#          previous_count = User.count
#          post :create, params: :admin_params
#          post :create, params: { session: { email:    users(:two).email,
#                                             password: users(:two).password
#          } }
#          expect(User.count).to eq(previous_count+1)
#        end
#        it "redirects to user" do
#          assert_redirected_to user_url(:admin_params)
        end
      end
      context "with invalid attributes" do
        describe "password shorter than 6 characters" do
          it "does not save the new user in the database" do
            previous_count = User.count
            # params[:tour_id] = nil
            # post :create, params: params
            # expect(Booking.count).to eq(previous_count)
          end
          it "redirects to root_url"
        end
        describe "password longer than 40 characters" do
          it "does not save the new user in the database" do
            previous_count = User.count
            # params[:tour_id] = nil
            # post :create, params: params
            # expect(Booking.count).to eq(previous_count)
          end
          it "redirects to root_url"
        end
        describe "email address wrong format" do
          it "does not save the new user in the database"
          it "redirects to root_url"
        end
        describe "email address already in use" do
          it "does not save the new user in the database"
          it "redirects to root_url"
        end
      end
    end

    it "logs out" do
      logout_path
      expect(response).to have_http_status(200)
#      it { is_expected.to set_session(:return_to).to(root_url) }
    end
  end

end