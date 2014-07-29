class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update]

  def index
    @incidents = Incident.all
  end

  def show
  end

  def new
    @incident = Incident.new
  end

  def edit
  end

  def create
    @incident = Incident.new(incident_params)

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

  private
    def set_incident
      @incident = Incident.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:title, :description, :severity, :status, :started_at, :detected_at)
    end
end
