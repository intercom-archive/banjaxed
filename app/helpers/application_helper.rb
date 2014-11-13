module ApplicationHelper
  def render_user_content(content)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ]

    result = pipeline.call(content)
    result[:output].to_s.html_safe
  end
end
