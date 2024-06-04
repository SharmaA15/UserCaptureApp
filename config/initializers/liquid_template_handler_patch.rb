module Liquid
	module Rails
		class TemplateHandler
			def self.call(template, source = nil)
				source ||= template.source
				"Liquid::Template.parse(#{source.inspect}).render(self)"
			end
		end
	end
end

ActionView::Template.register_template_handler :liquid, Liquid::Rails::TemplateHandler
