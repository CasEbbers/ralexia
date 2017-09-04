module OrganizationsHelper
  def organization_with_logo(organization, size='17x17')
    organization_html = image_tag("organization/#{organization.slug}", size: size)
    organization_html << " #{organization.name}"
  end

  def organization_switcher
    content_tag(:ul, class: 'dropdown-menu') do
      Organization.all.map { |organization|
        next if organization == current_organization
        content_tag(:li, link_to(switch_organization_path(organization), method: :post) do
          image_tag("organization/#{organization.slug}", size: '17x17') + ' ' + organization.name
        end)
      }.join.html_safe
    end
  end

  def collapsed_organizations(event)
    content_tag(:div, class: 'collapse', id: "event_#{event.id}_organizations") do
      event.organizations.map { |organization|
        next if organization == event.organizer
        organization_with_logo(organization)
      }.compact.join('<br>').html_safe
    end
  end
end
