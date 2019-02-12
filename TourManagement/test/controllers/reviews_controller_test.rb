require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest

  setup do

    # Get fixtures
    @review = reviews(:one)
    @user = users(:one)

    # Log in a user (gotta have a logged-in user to associate with any new reviews)
    # But cannot use session helper from outside of the controller
    # https://stackoverflow.com/questions/39465941/how-to-use-session-in-the-test-controller-in-rails-5?rq=1
    # So, this is kind of a hack to fake a logged-in user
    # Mimics params sent when logging in manually on the development application
    post login_url, params: { session: { email: @user.email, password: @user.password } }

  end

  test "should get index" do
    get reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_review_url
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post reviews_url, params: { review: {
        content: @review.content,
        subject: @review.subject,
        tour_id: @review.tour_id,
        user_id: @review.user_id
      } }
    end

    assert_redirected_to review_url(Review.last)
  end

  test "should show review" do
    get review_url(@review)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_url(@review)
    assert_response :success
  end

  test "should update review" do
    patch review_url(@review), params: { review: { content: @review.content, subject: @review.subject, tour_id: @review.tour_id, user_id: @review.user_id } }
    assert_redirected_to review_url(@review)
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete review_url(@review)
    end

    assert_redirected_to reviews_url
  end
end
