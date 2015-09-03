require 'rails_helper'

RSpec.describe GadgetsController, type: :controller do
  let(:author) do
    FactoryGirl.create :user, email: 'pablo@escobar.com',
                                         password: 'qwertyuiop',
                                         password_confirmation: 'qwertyuiop'
  end

  let!(:valid_gadget) { Gadget.create! valid_attributes  }

  let(:valid_attributes) do
    { name: 'iPod', description: 'Music listening devise', user_id: author.id }
  end

  let(:invalid_attributes) do
    { name: 'bl', description: 'Music listening devise', user_id: author.id }
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'return list of gadgets' do
      get :index
      expect(assigns(:gadgets)).to eq([valid_gadget])
    end
  end

  describe 'GET #new' do
    it 'assigns a new gadget as @gadget' do
      get :new
      expect(assigns(:gadget)).to be_a_new(Gadget)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Gadget' do
        expect {
          post :create, gadget: valid_attributes
        }.to change(Gadget, :count).by(1)
      end

      it 'assigns a newly created gadget as @gadget' do
        post :create, gadget: valid_attributes
        expect(assigns(:gadget)).to be_a(Gadget)
        expect(assigns(:gadget)).to be_persisted
      end

      it 'redirects to the created gadget' do
        post :create, gadget: valid_attributes
        expect(response).to redirect_to(Gadget.last)
      end
    end

    context 'with invalid params' do
      before do
        post :create, gadget: invalid_attributes
      end

      it 'assigns a newly created but unsaved gadget as @gadget' do
        expect(assigns(:gadget)).to be_a_new(Gadget)
      end

      it 're-renders the "new" template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    it 'returns http success' do
      put :update, id: 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete :destroy, id: 1
      expect(response).to have_http_status(:success)
    end
  end
end
