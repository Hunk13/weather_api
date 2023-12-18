require 'rails_helper'

RSpec.describe CityValidator do
  subject { described_class.new(city) }

  describe '#valid?' do
    context 'when city is nil' do
      let(:city) { nil }
      it 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end

    context 'when city is valid' do
      let(:city) { 'New York' }
      it 'returns true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when city contains numbers' do
      let(:city) { 'New York 123' }
      it 'returns false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end

  describe '#error_message' do
    context 'when city is nil' do
      let(:city) { nil }
      it 'returns appropriate message' do
        expect(subject.error_message).to eq('City must be present.')
      end
    end

    context 'when city contains numbers' do
      let(:city) { 'New York 123' }
      it 'returns appropriate message' do
        expect(subject.error_message).to eq('City contains invalid characters.')
      end
    end
  end
end
