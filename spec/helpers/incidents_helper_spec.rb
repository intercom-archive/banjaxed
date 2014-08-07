require 'rails_helper'

RSpec.describe IncidentsHelper, type: :helper do
  describe '#incident_severity_label' do
    context "with a known severity" do
      let(:incident) { Incident.new(severity: 'critical') }
      subject(:label_html) { helper.incident_severity_label(incident) }

      it "outputs the severity in uppercase" do
        expect(label_html).to match(/CRITICAL/)
      end

      it "applies the corresponding label" do
        expect(label_html).to match(/label-danger/)
      end
    end

    context "with an unknown severity" do
      let(:incident) { Incident.new(severity: 'notreal') }
      subject(:label_html) { helper.incident_severity_label(incident) }

      it "outputs the severity in uppercase" do
        expect(label_html).to match(/NOTREAL/)
      end

      it "applies the default label" do
        expect(label_html).to match(/label-default/)
      end
    end
  end
end
