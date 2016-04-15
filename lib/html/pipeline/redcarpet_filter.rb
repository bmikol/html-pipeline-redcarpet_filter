require "html/pipeline/redcarpet_filter/version"
require "html/pipeline/filter"
require "redcarpet"

module HTML
  class Pipeline
    class RedcarpetFilter < Filter
     	
     	# Run Redcarpet text filters (default settings with autolinking and fenced code blocks enabled)
    	def call
    		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
    		markdown.render(html)
    	end

    end
  end
end
