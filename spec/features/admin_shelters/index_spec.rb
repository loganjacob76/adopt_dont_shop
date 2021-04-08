require 'rails_helper'

RSpec.describe 'admin shelter index' do
    before :each do
        @shelter1 = Shelter.create!(foster_program: true, name: 'Paws of Life', city: 'Denver', rank: 3)
        @shelter2 = Shelter.create!(foster_program: false, name: 'Pets R Us', city: 'Tampa', rank: 9)
    end

    it 'lists all shelters in reverse alphabetical order' do
        visit '/admins/shelters'

        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content(@shelter2.name)
        expect(@shelter2.name).to appear_before(@shelter1.name)
    end
end