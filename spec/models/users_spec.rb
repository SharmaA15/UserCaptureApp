# spec/models/users_spec.rb

require 'rails_helper'

RSpec.describe "UserCaptureApp", type: :model do
  describe "total number of user records" do
    # Test for initial count of user records
    it "initial count should be zero" do
      expect(User.count).to eq(0)
    end

    # Test for increasing count after fetching new records
    it "increases count by 20 after fetching new records" do
      initial_count = User.count
      FetchAndStoreUsersJob.perform_now
      expect(User.count).to eq(initial_count + 20)
    end

    # Test for deleting a user record
    it "deletes a user record" do
      user = User.create(name: "Test User", gender: "male", age: 30)
      expect(User.count).to eq(1)
      user.destroy
      expect(User.count).to eq(0)
    end

    # Test for updating DailyRecord after user deletion
    it "updates DailyRecord after user deletion" do
      user1 = User.create(name: "John Doe", gender: "male", age: 25)
      user2 = User.create(name: "Jane Doe", gender: "female", age: 30)
      FetchAndStoreUsersJob.perform_now
      initial_daily_record = DailyRecord.find_by(date: Date.today)

      # Fetch the initial male and female average counts
      initial_male_avg_count = initial_daily_record&.male_avg_count || 0
      initial_female_avg_count = initial_daily_record&.female_avg_count || 0

      expect(initial_male_avg_count).to eq(1)
      expect(initial_female_avg_count).to eq(1)
      
      user1.destroy
      updated_daily_record = DailyRecord.find_by(date: Date.today)
      expect(updated_daily_record.male_avg_count).to eq(0)
      expect(updated_daily_record.female_avg_count).to eq(1)
    end
  end
end