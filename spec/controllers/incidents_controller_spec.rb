require 'rails_helper'

RSpec.describe IncidentsController, type: :controller do

  let(:valid_attributes) {
    { title: "MyTitle", description: "MyDescription", severity: 'critical' }
  }

  let(:invalid_attributes) {
    { title: "", description: "" }
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
    let!(:closed_incident) {
      FactoryGirl.create(:incident, status: 'closed')
    }

    context "with no status parameter" do
      it "assigns all incidents as @incidents" do
        get :index, {}
        expect(assigns(:incidents)).to eq([incident, closed_incident])
      end
    end

    context "with a closed status parameter" do
      it "assigns only closed incidents as @incidents" do
        get :index, { status: 'closed' }
        expect(assigns(:incidents)).to eq([closed_incident])
      end
    end

    context "with an invalid status parameter" do
      it "ignores the status parameter and assigns all incidents as @incidents" do
        get :index, { status: 'something' }
        expect(assigns(:incidents)).to eq([incident, closed_incident])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested incident as @incident" do
      get :show, { id: incident.to_param }
      expect(assigns(:incident)).to eq(incident)
    end

    it "assigns a new comment as @comment" do
      get :show, { id: incident.to_param }
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "GET new" do
    it "assigns a new incident as @incident" do
      get :new, {}
      expect(assigns(:incident)).to be_a_new(Incident)
    end
  end

  describe "GET edit" do
    it "assigns the requested incident as @incident" do
      get :edit, { id: incident.to_param }
      expect(assigns(:incident)).to eq(incident)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Incident" do
        expect {
          post :create, { incident: valid_attributes }
        }.to change(Incident, :count).by(1)
      end

      it "assigns a newly created incident as @incident" do
        post :create, { incident: valid_attributes }
        expect(assigns(:incident)).to be_a(Incident)
        expect(assigns(:incident)).to be_persisted
      end

      it "redirects to the created incident" do
        post :create, { incident: valid_attributes }
        expect(response).to redirect_to(Incident.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved incident as @incident" do
        post :create, { incident: invalid_attributes }
        expect(assigns(:incident)).to be_a_new(Incident)
      end

      it "re-renders the 'new' template" do
        post :create, { incident: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { title: "NewTitle" }
      }

      it "updates the requested incident" do
        put :update, { id: incident.to_param, incident: new_attributes }
        incident.reload
        expect(incident.title).to eq("NewTitle")
      end

      it "assigns the requested incident as @incident" do
        put :update, { id: incident.to_param, incident: valid_attributes }
        expect(assigns(:incident)).to eq(incident)
      end

      it "redirects to the incident" do
        put :update, { id: incident.to_param, incident: valid_attributes }
        expect(response).to redirect_to(incident)
      end
    end

    describe "with invalid params" do
      it "assigns the incident as @incident" do
        put :update, { id: incident.to_param, incident: invalid_attributes }
        expect(assigns(:incident)).to eq(incident)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: incident.to_param, incident: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "PATCH status" do
    describe "with valid params" do
      it "updates the incident's status" do
        patch :status, { id: incident.to_param, status: "closed" }
        incident.reload
        expect(incident.status).to eq("closed")
      end

      it "redirects to the incident" do
        patch :status, { id: incident.to_param, status: "closed" }
        expect(response).to redirect_to(incident)
      end
    end

    describe "with invalid params" do
      it "doesn't update the incident's status" do
        patch :status, { id: incident.to_param, status: "bad_status" }
        incident.reload
        expect(incident.status).to eq("open")
      end

      it "redirects to the incident" do
        patch :status, { id: incident.to_param, status: "bad_status" }
        expect(response).to redirect_to(incident)
      end
    end
  end

end
