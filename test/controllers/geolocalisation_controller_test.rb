require 'test_helper'

class GeolocalisationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get geolocalisation_index_url
    assert_response :success
  end

end
