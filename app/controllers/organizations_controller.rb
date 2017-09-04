class OrganizationsController < ApplicationController
  authorize_resource

  def switch
    @organization = Organization.friendly.find(params[:id])
    current_user.update(current_organization: @organization)
    redirect_to request.referer
  end
end
