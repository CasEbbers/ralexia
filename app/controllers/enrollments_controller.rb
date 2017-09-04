class EnrollmentsController < ApplicationController
  load_and_authorize_resource :event
  authorize_resource :enrollment, through: :event

  def edit
    @user = User.find(params[:id])
    @enrollment = Enrollment.find_or_initialize_by(user: @user, event: @event)
  end

  def create
    @user = User.find_by_id(params[:enrollment][:user_id]) if current_user.planner?
    @user ||= current_user
    @enrollment = Enrollment.find_or_initialize_by(user: @user, event: @event)
    @enrollment.enrollment_type_id = params[:enrollment][:enrollment_type_id]


    respond_to do |format|
      if @enrollment.save
        format.js
        format.html { redirect_to @event }
      else
        print @enrollment.errors.full_messages
        format.js { head :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end
end
