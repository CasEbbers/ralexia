module EnrollmentsHelper
  NATURE_TO_CLASS = {
    yes: 'success',
    maybe: 'warning',
    no: 'danger',
  }

  def enrollment_label(enrollment)
    return content_tag(:span, _('Unknown'), class: 'label label-default') if enrollment.nil?
    content_tag(
      :span,
      enrollment.enrollment_type.name,
      class: "label label-#{NATURE_TO_CLASS[enrollment.enrollment_type.nature.to_sym]}"
    )
  end
end
