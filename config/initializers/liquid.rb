Rails.application.config.to_prepare do
    ActionView::Template.register_template_handler :liquid, Liquid::Rails::TemplateHandler
end
  