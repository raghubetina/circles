require 'rails_helper'

RSpec.describe "contacts#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/contacts/#{contact.id}", params: params
  end

  describe 'basic fetch' do
    let!(:contact) { create(:contact) }

    it 'works' do
      expect(ContactResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('contacts')
      expect(d.id).to eq(contact.id)
    end
  end
end
