require 'rails_helper'

RSpec.describe ContactResource, type: :resource do
  describe 'serialization' do
    let!(:contact) { create(:contact) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(contact.id)
      expect(data.jsonapi_type).to eq('contacts')
    end
  end

  describe 'filtering' do
    let!(:contact1) { create(:contact) }
    let!(:contact2) { create(:contact) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: contact2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([contact2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:contact1) { create(:contact) }
      let!(:contact2) { create(:contact) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            contact1.id,
            contact2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            contact2.id,
            contact1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
