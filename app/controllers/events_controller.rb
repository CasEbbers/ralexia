class EventsController < ApplicationController
  before_action :require_organization, only: [:new, :edit]
  load_and_authorize_resource

  def index
    @q = Event.ransack(params[:q])
    events = @q.result
    events = events.where('starts_at >= ?', DateTime.now) unless params[:q]
    events = events.includes(:enrollments, :locations, :organizer).order(:starts_at)

    @events = Hash.new{ |h, k| h[k] = [] }
    events.each do |event|
      @events[event.starts_at.to_date].push(event)
    end
  end

  def show
  end

  def new
    @event = Event.new
    @event.organizations << current_organization
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_organization

    if @event.save
      redirect_to @event, notice: _('Event is succesfully updated.')
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event is successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: _('%{event} deleted') % { event: @event.name }
  end

  private

  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :enrollment_closed, :option, :risky, :kegs, :bartender_instruction, organization_ids: [], location_ids: [])
  end
end
