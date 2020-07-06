require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #new' do

    before { get :new }

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'sets @user' do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do

    context 'Valid Input' do

      before { post :create, params: { user: attributes_for(:user) } }

      it 'assigns the @user instance variable' do
        expect(assigns(:user)).not_to be_nil
      end

      it 'sets the notice flash message' do
        expect(flash[:notice]).not_to be_blank
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'Invalid Input' do

      before { post :create, params: { user: attributes_for(:user, password: '') } }

      it 'flashes error message' do
        expect(flash[:error]).not_to be_blank
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end
end