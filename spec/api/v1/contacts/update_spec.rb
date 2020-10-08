require 'rails_helper'

RSpec.describe "contacts#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/contacts/#{contact.id}", payload
  end

  describe 'basic update' do
    let!(:contact) { create(:contact) }

    let(:payload) do
      {
        data: {
          id: contact.id.to_s,
          type: 'contacts',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ContactResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { contact.reload.attributes }
    end
  end
end
