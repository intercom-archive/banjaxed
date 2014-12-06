class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :status]

  def index
    @incidents = Incident.order(id: :desc)

    if params.key?(:status) && Incident::STATUS_VALUES.include?(params[:status])
      @incidents = @incidents.where(status: params[:status])
    end

    respond_to do |format|
      format.html { render :layout => true }
      format.atom {
        @updated = last_updated(@incidents)
        render :layout => false
      }

      # RSS feed permanently redirected to the ATOM feed
      format.rss { redirect_to incidents_url(:format => :atom), :status => :moved_permanently }
    end
  end

  def show
    @comment = @incident.comments.new
  end

  def new
    @incident = Incident.new
  end

  def edit
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user

    if @incident.save
      redirect_to @incident, notice: 'Incident was successfully created.'
    else
      render :new
    end
  end

  def update
    if @incident.update(incident_params)
      redirect_to @incident, notice: 'Incident was successfully updated.'
    else
      render :edit
    end
  end

  def status
    if @incident.update(params.permit(:status))
      redirect_to @incident, notice: 'Incident status successfully updated.'
    else
      redirect_to @incident, flash: { error: 'Incident status could not be updated!' }
    end
  end

  private
    def set_incident
      @incident = Incident.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:title, :description, :severity, :status, :started_at, :detected_at)
    end

    def last_updated(incidents)
      updated_at = incidents.first.updated_at
      incidents.each do |incident|
        updated_at = incident.updated_at if incident.updated_at > updated_at
      end
      updated_at
    end
end
