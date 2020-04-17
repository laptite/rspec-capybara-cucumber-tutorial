require 'rails_helper'

describe AchievementsController do

  describe "GET index" do 
    before { get :index }

    it "renders :index template" do 
      expect(response).to render_template(:index)
    end

    it "assigns only public achievements to template" do 
      global_achievement = create(:global_achievement)
      admin_achievement = create(:admin_achievement)
      expect(assigns(:achievements)).to match_array([global_achievement])
    end
  end

  describe "GET new" do 
    before { get :new }
    it "renders :new template" do 
      expect(response).to render_template(:new)
    end

    it "assigns new Achievement to @achievement" do 
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe "GET create" do 
    context "valid data" do
      let(:valid_data) { attributes_for(:global_achievement) }
      it 'creates new achievement in database' do 
        expect {
          post :create, params: { achievement: valid_data }
        }.to change(Achievement, :count).by(1)
      end

      it 'redirects to achievements#show' do 
        post :create, params: { achievement: valid_data }
        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
      end
    end

    context "invalid data" do 
      let(:invalid_data) { attributes_for(:global_achievement, title: '') }
      it "renders :new template" do 
        post :create, params: { achievement: invalid_data }
        expect(response).to render_template(:new)
      end

      it "doesn't create new achievement in the database" do 
        expect {
          post :create, params: { achievement: invalid_data }
        }.not_to change(Achievement, :count)
      end
    end
  end

  describe "GET show" do 
    let(:achievement) { FactoryBot.create(:global_achievement) }

    it "renders :show template" do
      get :show, params: { id: achievement.id }
      expect(response).to render_template(:show)
    end

    it "assigns requested achievement to @achievement" do
      get :show, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe "GET edit" do 
    let(:achievement) { FactoryBot.create(:global_achievement) }

    it "renders :edit template" do 
      get :edit, params: { id: achievement.id }
      expect(response).to render_template(:edit)
    end

    it "assigns the requested achievement to template" do 
      get :edit, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe "PUT update" do 
    let(:achievement) { FactoryBot.create(:global_achievement) }

    context "valid data" do 
      let(:valid_data) { FactoryBot.attributes_for(:global_achievement, title: "New title") }
      it "redirects to achievements#show" do 
        # Need to pass in id for URL
        put :update, params: { id: achievement.id, achievement: valid_data }
        expect(response).to redirect_to(achievement)
      end
      it "updates achievement in the database" do 
        put :update, params: { id: achievement.id, achievement: valid_data }
        achievement.reload
        expect(achievement.title).to eq("New title")
      end
    end

    context "invalid data" do 
      let(:invalid_data) { FactoryBot.attributes_for(:global_achievement, title: '', description: 'new') }
      it "renders :edit template" do 
        get :edit, params: { id: achievement.id, achievement: invalid_data }
        expect(response).to render_template(:edit)
      end

      it "doesn't update achievement in the database" do 
        put :update, params: { id: achievement.id, achievement: invalid_data }
        expect(achievement.description).not_to eq('new')
      end
    end
  end

  describe "DELETE destroy" do
    let(:achievement) { FactoryBot.create(:global_achievement) }

    it "deletes the achievement from the database" do 
      delete :destroy, params: { id: achievement.id }
      expect(Achievement.exists?(achievement.id)).to be_falsey
    end

    it "redirects to achievements#index" do
      delete :destroy, params: { id: achievement.id }
      expect(response).to redirect_to(root_path)
    end
  end

end