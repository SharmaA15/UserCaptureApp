class UsersController < ApplicationController
  def index
    # Retrieve all users from the database
    users = User.all
    
    # Read the Liquid template file
    template = File.read("#{Rails.root}/app/views/users/index.liquid")
    
    # Parse the Liquid template
    liquid_template = Liquid::Template.parse(template)
    
    # Generate CSRF token for form authenticity
    csrf_token = form_authenticity_token
    
    # Define the context variables to pass to the Liquid template
    context = {
      "view" => view_context,
      "users_path" => users_path,
      "daily_records_path" => daily_records_path,
      "csrf_token" => csrf_token,
      "users" => users.map(&:attributes)
      # Add any additional variables you need to pass to the Liquid template here
    }
    
    # Render the Liquid template with the context variables
    rendered_template = liquid_template.render(context.stringify_keys)
    
    # Render the HTML output
    render html: rendered_template.html_safe
  end

  def destroy
    # Find the user by ID
    @user = User.find(params[:id])
    
    # Get the gender of the user
    gender = @user.gender

    # Attempt to delete the user
    if @user.destroy
      # Find the daily record for today's date
      daily_record = DailyRecord.find_by(date: Date.today)
      
      # Update the daily record counts based on the user's gender
      if gender == 'male'
        daily_record.update(male_count: daily_record.male_count - 1)
      else
        daily_record.update(female_count: daily_record.female_count - 1)
      end
      
      # Respond with success message
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      # Respond with error message if deletion fails
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
