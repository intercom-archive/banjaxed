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

  describe '#incident_status_switcher_item' do
    subject(:switcher_item) {
      helper.incident_status_switcher_item(status, "label", active_status)
    }

    context "when status is present" do
      let(:status) { 'open' }
      let(:active_status) { nil }

      it "outputs a link to incidents filtered by status" do
        expect(switcher_item).to match(/href="\/incidents\?status=open"/)
      end
    end

    context "when status is not present" do
      let(:status) { nil }
      let(:active_status) { nil }

      it "outputs a link to all incidents" do
        expect(switcher_item).to match(/href="\/incidents"/)
      end
    end

    context "when active_status matches status" do
      let(:status) { 'open' }
      let(:active_status) { 'open' }

      it "adds the active class to the list item" do
        expect(switcher_item).to match(/<li class="active">/)
      end
    end

    context "when active_status doesn't match status" do
      let(:status) { 'open' }
      let(:active_status) { 'closed' }

      it "doesn't add the active class to the list item" do
        expect(switcher_item).not_to match(/<li class="active">/)
      end
    end
  end

  describe "#incident_user_name" do
    subject(:incident_user_name) { helper.incident_user_name(incident) }

    let(:incident) { FactoryGirl.create(:incident, user: user) }

    let(:user) do
      FactoryGirl.create(:user, github_username: 'gh_user', name: name)
    end

    context "when the user has a name set" do
      let(:name) { "my_name" }

      it "returns the user's name" do
        expect(incident_user_name).to eq("my_name")
      end
    end

    context "when the user has no name set" do
      let(:name) { nil }

      it "returns the user's GitHub username" do
        expect(incident_user_name).to eq("gh_user")
      end
    end
  end
end
