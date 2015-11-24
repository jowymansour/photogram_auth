class TimelineController < ApplicationController

  def index
     @statuses = current_user.timeline_statuses.order("created_at DESC")
  end

end
