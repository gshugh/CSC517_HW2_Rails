require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  setup do
    @photo = photos(:one)
    @tour = tours(:one)
  end

  test "should get index" do
    # The photos index view is never used to show ALL photos,
    #   only to show photos for a specific tour
    get photos_url(tour_id: @tour.id)
    assert_response :success
  end

  test "should get new" do
    # The photos new view expects to be passed the tour we're currently working with,
    #   so that the user doesn't have to select a tour
    get new_photo_url(tour_id: @tour.id)
    assert_response :success
  end

  test "should create photo" do
    assert_difference('Photo.count') do
      post photos_url, params: { photo: { name: @photo.name, tour_id: @photo.tour_id } }
    end

    assert_redirected_to photo_url(Photo.last)
  end

  test "should show photo" do
    get photo_url(@photo)
    assert_response :success
  end

  test "should get edit" do
    get edit_photo_url(@photo)
    assert_response :success
  end

  test "should update photo" do
    patch photo_url(@photo), params: { photo: { name: @photo.name, tour_id: @photo.tour_id } }
    assert_redirected_to photo_url(@photo)
  end

  test "should destroy photo" do

    # Destroy the photo
    assert_difference('Photo.count', -1) do
      delete photo_url(@photo)
    end

    # After a photo is destroyed, we should redirect to the photos index view
    #   with an extra parameter for which tour we are currently dealing with
    # The photos index view is never used to show ALL photos,
    #   only to show photos for a specific tour
    # So here, we use a regex to describe where we expect to be redirected to
    # https://api.rubyonrails.org/v5.2.2/classes/ActionDispatch/Assertions/ResponseAssertions.html
    assert_redirected_to /http.*photos\?tour_id\=.*/

  end
end
