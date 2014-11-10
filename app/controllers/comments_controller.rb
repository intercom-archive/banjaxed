class CommentsController < ApplicationController
  before_action :set_incident

  def index
    @comments = @incident.comments.since(params[:after_id]).order(:id)
  end

  def create
    @comment = @incident.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private
    def set_incident
      @incident = Incident.find(params[:incident_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
