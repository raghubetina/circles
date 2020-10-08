require 'rails_helper'

RSpec.describe "contacts#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/contacts", params: params
  end

  describe 'basic fetch' do
    let!(:contact1) { create(:contact) }
    let!(:contact2) { create(:contact) }

    it 'works' do
      expect(ContactResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['contacts'])
      expect(d.map(&:id)).to match_array([contact1.id, contact2.id])
    end
  end
end
