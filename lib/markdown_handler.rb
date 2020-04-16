module MarkdownHandler
  class << self
    def call(template, source)
      compiled_source = haml.call(template, source)
      "MarkdownHandler.render(begin;#{compiled_source};end)"
    end

    def render(text)
      key = cache_key(text)
      Rails.cache.fetch key do
        markdown.render(text).html_safe
      end
    end

    private

      def markdown
        @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, autolink: true, space_after_headers: true)
      end

      def haml
        @haml ||= ActionView::Template.registered_template_handler(:haml)
      end

      def cache_key(text)
        Digest::MD5.hexdigest(text)
      end
  end

  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end
end