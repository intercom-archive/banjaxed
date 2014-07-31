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

  describe "GET new" do
    it "assigns a new comment as @comment" do
      get :new, { incident_id: incident.to_param }
      expect(assigns(:comment)).to be_a_new(Comment)
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

      it "redirects to the incident view" do
        post :create, { incident_id: incident.to_param, comment: valid_attributes }
        expect(response).to redirect_to(incident)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, { incident_id: incident.to_param, comment: invalid_attributes }
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        post :create, { incident_id: incident.to_param, comment: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

end
