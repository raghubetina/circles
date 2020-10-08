require 'rails_helper'

RSpec.describe ContactResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'contacts',
          attributes: { }
        }
      }
    end

    let(:instance) do
      ContactResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Contact.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:contact) { create(:contact) }

    let(:payload) do
      {
        data: {
          id: contact.id.to_s,
          type: 'contacts',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ContactResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { contact.reload.updated_at }
      # .and change { contact.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:contact) { create(:contact) }

    let(:instance) do
      ContactResource.find(id: contact.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Contact.count }.by(-1)
    end
  end
end
