require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:file) { File.new(Rails.root + 'spec/fixtures/files/chillywilly.jpg') }
  let(:image) { build :image, image: file }

  it 'has a valid factory' do
    expect(image).to be_valid
  end

  describe 'valid format' do
    it 'should be valid' do
      expect(image.valid?).to be true
    end
  end

  describe 'invalid format' do
    let(:file) { File.new(Rails.root + 'spec/fixtures/files/wrong_format.txt') }

    it 'should raise error' do
      expect{image.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'large file' do
    let(:large_image) do
      FactoryGirl.build(:image, image_file_name: 'same-name.png',
                                            image_file_size: 120.megabytes,
                                            image_content_type: 'image/png')
    end

    it 'should be invalid image' do
      expect(large_image.valid?).to be false
    end

    it 'should raise error' do
      expect{large_image.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
