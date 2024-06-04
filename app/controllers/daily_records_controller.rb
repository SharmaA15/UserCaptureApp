class DailyRecordsController < ApplicationController
  def index
    # Fetch all daily records from the database
    daily_records = DailyRecord.all

    # Read the Liquid template file
    template = File.read("#{Rails.root}/app/views/daily_records/index.liquid")

    # Parse the Liquid template
    liquid_template = Liquid::Template.parse(template)

    # Generate a CSRF token for form authenticity
    csrf_token = form_authenticity_token

    # Define the context variables to pass to the Liquid template
    context = {
      "view" => view_context,
      "users_path" => users_path,
      "daily_records_path" => daily_records_path,
      "csrf_token" => csrf_token,
      "daily_records" => daily_records.map(&:attributes)
      # Add any additional variables you need to pass to the Liquid template here
    }

    # Render the Liquid template with the context variables
    rendered_template = liquid_template.render(context.stringify_keys)

    # Render the HTML output
    render html: rendered_template.htm
