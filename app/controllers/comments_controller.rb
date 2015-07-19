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
     comment_prev = @comment.content_was
     if @comment.update(comment_params)
       Action.create(:user_id=>current_user.id,:incident_id=>@comment.incident_id, :data => {:user_name=> current_user.name, :id=>@comment.id,:action_type=>"comment edited",:from=>comment_prev,:to=>@comment.content,:time=>Time.now.utc})
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
      Action.create(:user_id=>current_user.id,:incident_id=>@comment.incident_id, :data => {:user_name=> current_user.name, :id=>@comment.id,:action_type=>"comment create",:from=>'',:to=>@comment.content,:time=>Time.now.utc})
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
      Pagerduty.new.post_note(@comment.incident_id, @comment.content)
    end
end
