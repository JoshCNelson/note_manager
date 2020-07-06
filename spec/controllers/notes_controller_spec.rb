require 'rails_helper'

describe NotesController, type: :controller do
  let(:note) { create(:note) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:user2) { create(:user) }
    before do
      controller.session[:user_id] = user.id
      note1 = create(:note, user_id: user.id)
      note2 = create(:note, user_id: user2.id)

      get :index
    end

    it 'render the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    before { get :new  }

    context 'User not signed in' do
      it 'redirects the user to the login screen' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end
    end

    context 'Signed in user' do
      before do
        controller.session[:user_id] = user.id
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'sets @note' do
        expect(assigns(:note)).to be_a_new(Note)
      end
    end
  end

  describe 'POST #create' do
    context 'User not signed in' do
      before { post :create, params: { note: attributes_for(:note) } }

      it 'redirects the user to the login screen' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end
    end

    context 'Signed in user' do
      before { controller.session[:user_id] = user.id }

      context 'Valid inputs' do
        before { post :create, params: { note: attributes_for(:note) } }

        it 'sets the notice flash message' do
          expect(flash[:notice]).not_to be_blank
        end

        it 'redirects the user to the notes dashboard' do
          expect(response).to redirect_to notes_path
        end

        it 'saves the note to the database' do
          expect(Note.count).to eq 1
        end
      end

      context 'Invalid inputs' do
        before { post :create, params: { note: attributes_for(:note, title: "", body: "") } }

        it 'flashes error message' do
          expect(flash[:error]).not_to be_blank
        end

        it 'renders the new template' do
          expect(response).to render_template(:new)
        end

        it 'does not save the note to the database' do
          expect(Note.count).to eq 0
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'User not signed in' do
      before { get :edit, params: { id: note.id } }

      it 'redirects the user to the login screen' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end
    end

    context 'Signed in user' do
      before do
        controller.session[:user_id] = user.id
        get :edit, params: { id: note.id }
      end

      it 'sets @note' do
        expect(assigns(:note)).to eq(note)
      end

      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #update' do
    context 'User not signed in' do
      before { post :update, params: { id: note.id, note: attributes_for(:note, title: 'updated title', body: 'updated body') } }

      it 'redirects the user to the login screen' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end
    end

    context 'Signed in user' do
      before { controller.session[:user_id] = user.id }

      context 'Valid inputs' do
        before { post :update, params: { id: note.id, note: attributes_for(:note, title: 'updated title', body: 'updated body') } }

        it 'updates the note' do
          note.reload
          expect(note.title).to eq "updated title"
          expect(note.body).to eq "updated body"
        end

        it 'sets the notice flash message' do
          expect(flash[:notice]).not_to be_blank
        end

        it 'redirects to notes dashboard' do
          expect(response).to redirect_to notes_path
        end
      end

      context 'Invalid inputs' do
        before { post :update, params: { id: note.id, note: attributes_for(:note, title: '', body: '') } }

        it 'flashes error message' do
          expect(flash[:error]).not_to be_blank
        end

        it 'renders the edit template' do
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'User not signed in' do
      before { delete :destroy, params: { id: note.id } }

      it 'redirects the user to the login screen' do
        expect(response).to redirect_to root_path
      end

      it 'sets the error flash message' do
        expect(flash[:error]).not_to be_blank
      end
    end

    context 'Signed in user' do
      before { controller.session[:user_id] = user.id }

      it 'deletes the note' do
        note = create(:note)
        expect(Note.count).to eq 1
        delete :destroy, params: { id: note.id }
        expect(Note.count).to eq 0
      end

      it 'sets the notice flash message' do
        delete :destroy, params: { id: note.id }
        expect(flash[:notice]).not_to be_blank
      end

      it 'redirects to notes' do
        delete :destroy, params: { id: note.id }
        expect(response).to redirect_to notes_path
      end
    end
  end
end