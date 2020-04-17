require 'rails_helper'

describe AchievementsController do

  shared_examples "global access to achievements" do 
    describe "GET index" do 
      before { get :index }

      it "renders :index template" do 
        expect(response).to render_template(:index)
      end

      it "assigns only public achievements to template" do 
        global_achievement = create(:global_achievement, user: user)
        admin_achievement = create(:admin_achievement, user: user)
        expect(assigns(:achievements)).to match_array([global_achievement])
      end
    end

    describe "GET show" do 
      let(:achievement) { create(:global_achievement, user: user) }

      it "renders :show template" do
        get :show, params: { id: achievement.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested achievement to @achievement" do
        get :show, params: { id: achievement.id }
        expect(assigns(:achievement)).to eq(achievement)
      end
    end
  end

  describe "guest user" do 
    let(:user) { create(:user) }

    it_behaves_like "global access to achievements"

    describe "GET new" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "redirects to the sign in page" do
        post :create, params: { achievement: attributes_for(:global_achievement) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      let(:achievement) { create(:global_achievement, user: user) }

      it "redirects to the sign in page" do 
        get :edit, params: { id: achievement.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "redirects to the sign in page" do 
        put :update, params: { id: create(:global_achievement, user: user), achievement: attributes_for(:global_achievement, title: "New Title")}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do 
      it "redirects to the sign in page" do 
        delete :destroy, params: { id: create(:global_achievement, user: user) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "authenticated user" do 
    let(:user) { create(:user) }
    before { sign_in(user) }

    it_behaves_like "global access to achievements"

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
        let(:valid_data) { attributes_for(:global_achievement, user: user) }
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

    context "is not the owner of the achievement" do 
      let(:other_user) { create(:user) }

      describe "GET edit" do
        let(:achievement) { create(:global_achievement, user: other_user) }

        it "redirects to the achievements page" do 
          get :edit, params: { id: achievement.id }
          expect(response).to redirect_to(achievements_path)
        end
      end

      describe "PUT update" do
        it "redirects to the achievements page" do 
          put :update, params: { id: create(:global_achievement, user: other_user), achievement: attributes_for(:global_achievement)}
          expect(response).to redirect_to(achievements_path)
        end
      end

      describe "DELETE destroy" do 
        it "redirects to the achievements page" do 
          delete :destroy, params: { id: create(:global_achievement, user: other_user) }
          expect(response).to redirect_to(achievements_path)
        end
      end
    end

    context "is the owner of the achievement" do 
      let(:achievement) { FactoryBot.create(:global_achievement, user: user) }
      
      describe "GET edit" do 
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
        context "valid data" do 
          let(:valid_data) { attributes_for(:global_achievement, title: "New title") }
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
        it "deletes the achievement from the database" do 
          delete :destroy, params: { id: achievement.id }
          expect(Achievement.exists?(achievement.id)).to be_falsey
        end

        it "redirects to achievements#index" do
          delete :destroy, params: { id: achievement.id }
          expect(response).to redirect_to(achievements_path)
        end
      end
    end
  end
end