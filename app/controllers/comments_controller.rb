class CommentsController < ApplicationController
  before_action :set_incident

  def index
    after_id = params[:after_id]
    query = @incident.comments
    query = query.where(id: (after_id.to_i + 1)..Float::INFINITY) if after_id
    render json: query
  end

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
