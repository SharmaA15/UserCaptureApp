require "test_helper"

class DailyRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_records_index_url
    assert_response :success
  end
end
