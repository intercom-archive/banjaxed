require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  let(:valid_attributes) {
    { content: "MyContent" }
  }

  let(:invalid_attributes) {
    { content: "" }
  }

  let(:incident) {
    FactoryGirl.create(:incident)
  }

  let(:current_user) {
    FactoryGirl.create(:user)
  }

  before(:each) {
    allow(controller).to receive(:current_user) { current_user }
  }

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Comment on the incident" do
        expect {
          post :create, { incident_id: incident.to_param, comment: valid_attributes }
        }.to change(incident.comments, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, { incident_id: incident.to_param, comment: valid_attributes }
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "gives a 2xx response" do
        post :create, { incident_id: incident.to_param, comment: valid_attributes }
        expect(response).to be_success
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, { incident_id: incident.to_param, comment: invalid_attributes }
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "gives a 4xx response" do
        post :create, { incident_id: incident.to_param, comment: invalid_attributes }
        expect(response).to be_client_error
      end
    end
  end

end
