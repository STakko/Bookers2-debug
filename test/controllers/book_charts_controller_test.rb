require 'test_helper'

class BookChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_charts_index_url
    assert_response :success
  end

end
