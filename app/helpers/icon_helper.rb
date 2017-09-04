module IconHelper
  def icon(names, options = {})
    options.include?(:base) ? fa_stacked_icon(names, options) : fa_icon(names, options)
  end
end
