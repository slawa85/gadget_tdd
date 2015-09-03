require 'rails_helper'

RSpec.describe Gadget, type: :model do
  let(:first_user) { FactoryGirl.create :user }
  let(:second_user) { FactoryGirl.create :user }
  let(:valid_gadget) do
    FactoryGirl.build :gadget,
      name: 'iPhone', description: 'I don\'t like it',
      user_id: first_user.to_param
  end

  describe 'validators' do
    let(:invalid_gadget) { FactoryGirl.build :gadget, name: 'bl', description: 'Funny things', user_id: first_user.to_param }

    context 'invalid gadget' do
      it 'should be invalid' do
        expect(invalid_gadget.valid?).to be false
      end

      it 'should raise an error' do
        expect{invalid_gadget.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      context 'empty name' do
        before do
          valid_gadget.name = nil
        end

        it 'should raise error' do
          expect{valid_gadget.save!}.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    context 'valid gadget' do
      it 'should be valid' do
        expect(valid_gadget.valid?).to be true
      end

      it 'should be created successfull' do
        expect(valid_gadget.save!).to be true
      end
    end
  end

  describe '#get_by' do
    before  { valid_gadget.save! }
    let!(:iPad) do
      FactoryGirl.create :gadget,
        name: 'iPad', description: 'I don\'t like it',
        user_id: second_user.to_param
    end

    it 'return only iPad' do
      expect(Gadget.get_by(first_user.to_param)).to eq([valid_gadget])
    end
  end

  describe 'image association' do
    context 'attach image' do
      let(:file) { File.new(Rails.root + 'spec/fixtures/files/chillywilly.jpg') }
      let(:image) { FactoryGirl.build :image, image: file, gadget_id: valid_gadget.to_param}
      before do
        valid_gadget.images << image
        valid_gadget.save!
      end

      it 'should have attached an image' do
        expect(valid_gadget.images).to_not be_empty
      end
    end

    context 'empty image' do
      before do
        valid_gadget.images << []
        valid_gadget.save!
      end

      it 'doesn\'t have any image' do
        expect(valid_gadget.images).to be_empty
      end
    end
  end

  describe '#search' do
    let!(:iPhone) { FactoryGirl.create :gadget, name: 'iPhone', description: 'Bla', user_id: first_user.id }
    let!(:iPad) { FactoryGirl.create :gadget, name: 'iPad', description: 'Bla Bla blas', user_id: first_user.id }

    context 'not empty search param' do
      it 'should return iPhone' do
        expect(subject.class.search 'blas', first_user.id).to eq([iPad])
      end
    end

    context 'empty search param' do
      it 'return all gadgets' do
        expect(subject.class.search nil, first_user.id).to eq([iPhone, iPad])
      end
    end
  end
end
