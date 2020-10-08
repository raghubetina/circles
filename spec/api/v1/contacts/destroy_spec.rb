require 'rails_helper'

RSpec.describe "contacts#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/contacts/#{contact.id}"
  end

  describe 'basic destroy' do
    let!(:contact) { create(:contact) }

    it 'updates the resource' do
      expect(ContactResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Contact.count }.by(-1)
      expect { contact.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
