require 'rails_helper'

describe GadgetsController, type: :controller do
  let(:author) { FactoryGirl.create :user }

  let(:valid_attributes) do
    { name: 'iPod', description: 'Music listening devise', user_id: author.id,
      images_attributes: [Hash[:image, fixture_file_upload('files/chillywilly.jpg', 'image/jpg')]] }
  end

  let(:invalid_attributes) do
    { name: 'bl', description: 'Music listening devise', user_id: author.id }
  end

  let!(:valid_gadget) { Gadget.create! valid_attributes  }

  shared_examples 'redirect when not logged in' do
    before do
      allow(controller).to receive(:authenticate_user!).and_call_original
    end

    it 'redirect to login page' do
      request
      expect(controller).to redirect_to(new_user_session_url)
    end
  end

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'GET #index' do
    it 'assigns all gadgets as @gadgets' do
      get :index
      expect(assigns(:gadgets)).to eq([valid_gadget])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested gadget as @gadget' do
      get :show, id: valid_gadget.to_param
      expect(assigns(:gadget)).to eq(valid_gadget)
    end
  end

  describe 'GET #new' do
    let(:request) { get :new }
    it_behaves_like 'redirect when not logged in'

    it 'assigns a new gadget as @gadget' do
      request
      expect(assigns(:gadget)).to be_a_new(Gadget)
    end
  end

  describe 'GET #edit' do
    let(:request) { get :edit, id: valid_gadget.to_param }
    it 'assigns the requested gadget as @gadget' do
      request
      expect(assigns(:gadget)).to eq(valid_gadget)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:request) { post :create, gadget: valid_attributes }

      it_behaves_like 'redirect when not logged in'

      it 'creates a new Gadget' do
        expect {
          request
        }.to change(Gadget, :count).by(1)
      end

      it 'assigns a newly created gadget as @gadget' do
        request
        expect(assigns(:gadget)).to be_a(Gadget)
        expect(assigns(:gadget)).to be_persisted
      end

      it 'redirects to the created gadget' do
        request
        expect(response).to redirect_to(Gadget.last)
      end
    end

    context 'with invalid params' do
      let(:request) { post :create, gadget: invalid_attributes }

      it_behaves_like 'redirect when not logged in'

      it 'assigns a newly created but unsaved gadget as @gadget' do
        request
        expect(assigns(:gadget)).to be_a_new(Gadget)
      end

      it 're-renders the "new" template' do
        request
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'IPhone', description: 'Bla bla bla bla' }
      end
      let(:request) { put :update, id: valid_gadget.to_param, gadget: new_attributes }

      it_behaves_like 'redirect when not logged in'

      it 'updates the requested gadget' do
        request
        valid_gadget.reload
        expect(valid_gadget.description).to eq(new_attributes[:description])
      end

      it 'assigns the requested gadget as @gadget' do
        request
        expect(assigns(:gadget)).to eq(valid_gadget)
      end

      it 'redirects to the gadget' do
        request
        expect(response).to redirect_to(valid_gadget)
      end
    end

    context 'with invalid params' do
      let(:request) { put :update, id: valid_gadget.to_param, gadget: invalid_attributes }

      it_behaves_like 'redirect when not logged in'

      it 'assigns the gadget as @gadget' do
        request
        expect(assigns(:gadget)).to eq(valid_gadget)
      end

      it 're-renders the "edit" template' do
        request
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:request) { delete :destroy, id: valid_gadget.to_param }

    it_behaves_like 'redirect when not logged in'

    it 'destroys the requested gadget' do
      expect {
        request
      }.to change(Gadget, :count).by(-1)
    end

    it 'redirects to the gadgets list' do
      request
      expect(response).to redirect_to(gadgets_url)
    end
  end
end
