require 'rails_helper'

describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    before { post :create, params: { email: user.email, password: user.password } }

    it 'authenticates the user' do
      expect(user.authenticate('password')).to eq(user)
    end

    it 'sets the session' do
      expect(session[:user_id]).to eq(user.id)
    end

    it 'sets the notice flash message' do
      expect(flash[:notice]).not_to be_blank
    end

    it 'redirects to the notes dashboard' do
      expect(response).to redirect_to notes_path
    end

    context 'invalid details' do
      let(:user) { build(:user, password: "") }

      before do
        post :create, params: { email: user.email, password: user.password }
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end

      it 'redirects to the login screen' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #destroy' do
    before { get :destroy }

    it 'sets the flash notice message' do
      expect(flash[:notice]).not_to be_blank
    end

    it 'empties the session' do
      expect(session[:user_id]).to be_nil
    end
  end
end