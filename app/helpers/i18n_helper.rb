module I18nHelper
  def language_switcher
    I18n.available_locales.map { |lang|
      next if I18n.locale.to_s == lang
      content_tag(:li, link_to(image_tag("locale/#{lang}"), locale: lang))
    }.join.html_safe
  end
end
