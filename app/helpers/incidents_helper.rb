module IncidentsHelper
  def incident_severity_label(incident)
    label_class = {
      'critical' => 'danger',
      'high' => 'warning',
      'medium' => 'primary'
    }[incident.severity] || 'default'

    content_tag :span, incident.severity.upcase, class: "label label-#{label_class}"
  end

  def incident_status_switcher_item(status, label, active_status)
    options = status == active_status ? { class: 'active' } : {}

    content_tag :li, options do
      link_to label, incidents_path(status: status)
    end
  end
end
