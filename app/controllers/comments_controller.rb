class CommentsController < ApplicationController
  before_action :set_incident

  def new
    @comment = @incident.comments.new
  end

  def create
    @comment = @incident.comments.new(comment_params)

    if @comment.save
      redirect_to @incident, notice: 'Comment was successfully created.'
    else
      render :new
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
