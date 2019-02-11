require 'test_helper'

class ToursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tour = tours(:one)
  end

  test "should get index" do
    get tours_url
    assert_response :success
  end

  test "should get new" do
    get new_tour_url
    assert_response :success
  end

  test "should create tour" do
    assert_difference('Tour.count') do
      post tours_url, params: { tour: {
        deadline: @tour.deadline,
        description: @tour.description,
        end_date: @tour.end_date,
        # Change from auto-generated test: tour name has uniqueness constraint
        # so cannot just use name from fixture tour
        name: "MyUniqueName",
        num_seats: @tour.num_seats,
        operator_contact: @tour.operator_contact,
        price_in_cents: @tour.price_in_cents,
        start_date: @tour.start_date,
        status: @tour.status
      } }
    end

    assert_redirected_to tour_url(Tour.last)
  end

  test "should show tour" do
    get tour_url(@tour)
    assert_response :success
  end

  test "should get edit" do
    get edit_tour_url(@tour)
    assert_response :success
  end

  test "should update tour" do
    patch tour_url(@tour), params: { tour: {
      deadline: @tour.deadline,
      description: @tour.description,
      end_date: @tour.end_date,
      # Change from auto-generated test: tour name has uniqueness constraint
      # so cannot just use name from fixture tour
      name: "MyNewUniqueName",
      num_seats: @tour.num_seats,
      operator_contact: @tour.operator_contact,
      price_in_cents: @tour.price_in_cents,
      start_date: @tour.start_date,
      status: @tour.status
    } }
    assert_redirected_to tour_url(@tour)
  end

  test "should destroy tour" do
    assert_difference('Tour.count', -1) do
      delete tour_url(@tour)
    end

    assert_redirected_to tours_url
  end

end
