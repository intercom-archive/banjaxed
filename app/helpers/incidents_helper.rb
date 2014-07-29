module IncidentsHelper
  def incident_severity_label(incident)
    label_class = {
      'critical' => 'danger',
      'high' => 'warning',
      'medium' => 'primary'
    }[incident.severity] || 'default'

    content_tag :span, incident.severity.upcase, class: "label label-#{label_class}"
  end
end
