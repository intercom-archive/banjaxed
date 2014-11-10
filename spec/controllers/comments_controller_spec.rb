require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

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

  describe "GET index" do
    let!(:first_comment) do
      incident.comments.create(content: "first comment", user: current_user)
    end

    let!(:second_comment) do
      incident.comments.create(content: "second comment", user: current_user)
    end

    describe "without an after_id parameter" do
      it "returns all comments on the incident" do
        xhr :get, :index, { incident_id: incident.to_param }
        expect(assigns(:comments)).to match([first_comment, second_comment])
      end
    end

    describe "with an after_id parameter" do
      let(:after_id) { first_comment.id }

      it "returns any comments on the incident with ids above after_id" do
        xhr :get, :index, { incident_id: incident.to_param, after_id: after_id }
        expect(assigns(:comments)).to match([second_comment])
      end
    end
  end

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
