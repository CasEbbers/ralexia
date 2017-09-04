module LayoutHelper
  def page_title(*titles)
    @page_title ||= []
    @page_title.push(*titles.compact) if titles.any?
    @page_title.join(" \u00b7 ")
  end

  def nav_link_to(name = nil, options = nil, pattern = '', html_options = nil, &block)
    klass ||= {}
    klass[:class] = 'active' if "#{params[:controller]}##{params[:action]}".include?(pattern)

    content_tag(:li, klass) do
      link_to(name, options, html_options, &block)
    end
  end
end
