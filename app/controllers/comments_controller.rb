class CommentsController < ApplicationController
  before_action :set_incident

  def index
    query = @incident.comments
    after_id = params[:after_id]
    query = query.where(id: (after_id.to_i + 1)..Float::INFINITY) if after_id

    render json: query.order(:id), include: :user
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
