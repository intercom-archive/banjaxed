class CommentsController < ApplicationController
  before_action :set_incident
  after_action :post_to_pagerduty, only: :create

  def index
    @comments = @incident.comments.since(params[:after_id]).order(:id)
  end

  def show
    @comment = @incident.comments.find(params[:id])
    render layout: false
  end

  def edit
    @comment = @incident.comments.find(params[:id])
    render layout: false
  end

  def update
     @comment = @incident.comments.find(params[:id])
     if @comment.update(comment_params)
       render @comment, layout: false
     else
       render :edit, layout: false
     end
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

    def post_to_pagerduty
      Pagerduty.new().post_note(@comment['incident_id'], @comment['content'])
    end
end
