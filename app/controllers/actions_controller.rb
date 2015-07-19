class ActionsController < ApplicationController
  include ActionsHelper

  def show
    @incident_id = params[:incident_id].to_i
    @incident_history = Action.where(:incident_id=>@incident_id)
    action_info(@incident_history)
  end
end
