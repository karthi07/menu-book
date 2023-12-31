require 'rails_helper'

RSpec.describe Menu, type: :model do
  context 'validations' do
    it { should validate_presence_of(:dish_name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
  end
end
