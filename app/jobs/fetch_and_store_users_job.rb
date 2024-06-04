require 'httparty'

class FetchAndStoreUsersJob < ApplicationJob
  queue_as :default

  def perform
    # Send HTTP GET request to the randomuser.me API to fetch user data
    response = HTTParty.get('https://randomuser.me/api/?results=20')
    
    # Parse the JSON response and extract the users data
    users = response.parsed_response['results']

    # Initialize variables to count male and female users
    male_count = 0
    female_count = 0

    # Iterate over each user data retrieved from the API response
    users.each do |user_data|
      # Find or initialize a user record based on the UUID
      user = User.find_or_initialize_by(uuid: user_data['login']['uuid'])
      
      # Update the user attributes with data from the API response
      user.update(
        gender: user_data['gender'],
        name: user_data['name'],
        location: user_data['location'],
        age: user_data['dob']['age']
      )

      # Increment male or female count based on the gender of the user
      if user_data['gender'] == 'male'
        male_count += 1
      else
        female_count += 1
      end
    end

    # Store the hourly male and female counts in Redis
    $redis.set('hourly_male_count', male_count)
    $redis.set('hourly_female_count', female_count)
  end
end
