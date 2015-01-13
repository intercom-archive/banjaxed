require 'rake'
require 'rails_helper'
require 'json'

RSpec.describe PagerdutyController, type: :controller do

  before(:all) {
    unless User.find_by(github_id: 766800)
      load File.expand_path("../../../lib/tasks/pagerduty.rake", __FILE__)
      Rake::Task.define_task(:environment)
      Rake::Task['pagerduty:create_user'].invoke
    end
  }

  describe "on pagerduty event" do
    before do
      fixture = File.read(File.expand_path(File.join(File.dirname(__FILE__), "../fixtures/pagerduty_payload.json")))
      post "callback", JSON.parse(fixture)
    end

    it "respond with success" do
      expect(response).to be_success
      expect(Incident.all.length).to eq(1)
      expect(Incident.find_by(title: "45645").status).to eq('resolved')
      expect(PagerdutyIncident.all.length).to eq(1)
      expect(PagerdutyIncident.find_by(pagerduty_id: "PIJ90N7").incident_id).to eq(Incident.find_by(title: "45645").id)
    end

  end

  describe "on pagerduty event but no pagerduty user exists" do
    before do
      User.find_by(github_id: 766800).delete
      fixture = File.read(File.expand_path(File.join(File.dirname(__FILE__), "../fixtures/pagerduty_payload.json")))
      post "callback", JSON.parse(fixture)
    end

    it "respond with 422" do
      expect(response.code).to eq("422")
      expect(Incident.all.length).to eq(0)
      expect(PagerdutyIncident.all.length).to eq(0)
    end
  end

end