class MembershipsController < ApplicationController
  before_action :require_organization
  load_and_authorize_resource

  def index
    @memberships = current_organization.memberships.order('active DESC').includes(:user).order('users.first_name')
  end

  def show
    events = @membership.user.tended.where('starts_at > ?', DateTime.now.beginning_of_month - 1.year).order('starts_at').map(&:event)
    @events = Hash.new{ |h, k| h[k] = [] }
    events.each do |event|
      @events[localize(event.starts_at, format: '%B %Y')].push(event)
    end
    @last_10_events = @membership.user.tended.order('starts_at DESC').limit(10).map(&:event)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user
      @membership = Membership.new(organization: current_organization, user: @user)

      if @membership.save
        redirect_to edit_membership_path(@membership)
      else
        @user = User.new
        @user.errors.add(:username, _('already member'))
        render :new
      end
    else
      #redirect_to new_user_path
    end
  end

  def update
    if @membership.update(edit_membership_params)
      redirect_to @membership
    else
      render :edit
    end
  end

  def destroy
    @membership.destroy
    redirect_to(memberships_url, notice: _('%{user} has been deleted.') % { user: @membership.user.name })
  end

  protected

  def edit_membership_params
    params.require(:membership).permit(:active, :bartender, :planner, :manager)
  end

end
