class HomeController < ApplicationController
  def index
    # Read the Liquid template file
    template = File.read("#{Rails.root}/app/views/home/index.liquid")

    # Parse the Liquid template
    liquid_template = Liquid::Template.parse(template)

    # Define the context variables to pass to the Liquid template
    context = {
      "view" => view_context,
      "users_path" => users_path,
      "daily_records_path" => daily_records_path
      # Add any additional variables you need to pass to the Liquid template here
    }

    # Render the Liquid template with the context variables
    rendered_template = liquid_template.render(context)

    # Render the HTML output
    render html: rendered_template.html_safe
  end  
end
