require 'rails_helper'

RSpec.describe Applicant do
    before :each do
        @john.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345)
    end
    
    describe 'attributes' do
        it { should have_many :pets }
        it { should have_many :adoption_applications }
        it { should validate_presence_of :name }
        it { should validate_presence_of :street }
        it { should validate_presence_of :city }
        it { should validate_presence_of :state }
        it { should validate_numericality_of :zip }
    end
end