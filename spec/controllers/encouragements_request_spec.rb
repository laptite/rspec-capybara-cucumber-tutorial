require 'rails_helper'

RSpec.describe EncouragementsController do
  let(:user)   { create(:user) }
  let(:author) { create(:user) }
  let(:achievement) { create(:global_achievement, user: user) }
  
  context 'GET new' do 
    context 'guest user' do 
      it 'is redirected back to achievement page' do
        get :new, params: { achievement_id: achievement.id }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns flash message' do 
        get :new, params: { achievement_id: achievement.id }
        expect(flash[:alert]).to eq("You must be logged in!")
      end
    end

    context 'authenticated user' do 
      let(:achievement) { create(:global_achievement, user: author) }
      before { sign_in(user) }

      it 'renders :new template' do 
        get :new, params: { achievement_id: achievement.id }
        expect(response).to render_template(:new)
      end

      it 'assigns new encouragement to template' do
        get :new, params: { achievement_id: achievement.id }
        expect(assigns(:encouragement)).to be_a_new(Encouragement)
      end
    end

    context 'achievement author' do 
      let(:achievement)   { create(:global_achievement, user: author) }
      let(:encouragement) { create(:encouragement, user: author, achievement: achievement) }
      before { sign_in(author) }
      
      it 'is redirected back to achievement page' do 
        get :new, params: { encouragement: encouragement, achievement_id: achievement.id }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns new encouragement to template' do
        get :new, params: { achievement_id: achievement.id }
        expect(flash[:alert]).to eq("You can't encourage yourself!")
      end
    end
    
    context 'user who already left encouragement on achievement' do 
      let(:achievement) { create(:global_achievement, user: author) }
      before do 
        sign_in(user)
        create(:encouragement, user: user, achievement: achievement)
      end 

      it 'is redirected back to achievement page' do 
        get :new, params: { achievement_id: achievement.id }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns flash message' do
        get :new, params: { achievement_id: achievement.id }
        expect(flash[:alert]).to eq("You can't encourage more than once!")
      end
    end
  end

  context 'POST create' do 
    let(:encouragement_params) { attributes_for(:encouragement) }

    context 'authenticated user' do 
      let(:user) { create(:user) }
      let(:achievement) { create(:global_achievement, user: build(:user)) }
      before { sign_in(user) }

      context 'valid data' do 
        it 'redirects back to achievements page' do 
          post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
          expect(response).to redirect_to(achievement_path(achievement))
        end

        it 'assigns encouragement to current user and achievement' do 
          post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
          encouragement = Encouragement.last
          expect(encouragement.user).to eq(user)
        end

        it 'assigns flash message' do 
          post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
          expect(flash[:notice]).to eq("Thanks for your encouragement!")
        end
      end

      context 'invalid data' do 
        let(:invalid_params) { attributes_for(:encouragement, message: nil)}

        it 'renders :new template' do 
          post :create, params: { achievement_id: achievement.id, encouragement: invalid_params }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'guest user' do 
      it 'is redirected back to achievement page' do
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns flash message' do 
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq("You must be logged in!")
      end
    end

    context 'achievement author' do 
      let(:achievement) { create(:global_achievement, user: author) }
      let(:encouragement) { create(:encouragement, user: author, achievement: achievement) }
      before { sign_in(author) }
      
      it 'is redirected back to achievement page' do 
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns new encouragement to template' do
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq("You can't encourage yourself!")
      end
    end
    
    context 'user who already left encouragement on achievement' do 
      let(:achievement) { create(:global_achievement, user: author) }
      before do 
        sign_in(user)
        create(:encouragement, user: user, achievement: achievement)
      end 

      it 'is redirected back to achievement page' do
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(response).to redirect_to(achievement_path(achievement))
      end

      it 'assigns flash message' do
        post :create, params: { achievement_id: achievement.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq("You can't encourage more than once!")
      end
    end
  end
end
