class TabulateDailyRecordsJob < ApplicationJob
  queue_as :default

  def perform
    # Retrieve hourly male and female counts from Redis and convert them to integers
    male_count = $redis.get('hourly_male_count').to_i
    female_count = $redis.get('hourly_female_count').to_i

    # Find or initialize a daily record for today's date
    daily_record = DailyRecord.find_or_initialize_by(date: Date.today)
    
    # Update the daily record with the male and female counts
    daily_record.update(male_count: male_count, female_count: female_count)
  end
end
