require 'rails_helper'

RSpec.describe 'admin shelter index' do
    before :each do
        @shelter1 = Shelter.create!(foster_program: true, name: 'Paws of Life', city: 'Denver', rank: 3)
        @shelter2 = Shelter.create!(foster_program: false, name: 'Pets R Us', city: 'Tampa', rank: 9)

        pet1 = @shelter1.pets.create!(adoptable: true, age: 1, breed: 'Labrador', name: 'Star')
        pet2 = @shelter1.pets.create!(adoptable: false, age: 4, breed: 'Mutt', name: 'Boo')
        john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')

        AdoptionApplication.create!(applicant_id: john.id, pet_id: pet1.id)
    end

    it 'lists all shelters in reverse alphabetical order' do
        visit '/admin/shelters'

        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content(@shelter2.name)
        expect(@shelter2.name).to appear_before(@shelter1.name)
    end

    it 'has a section for shelters with pending applications' do
        visit '/admin/shelters'

        within 'div#pending' do
            expect(page).to have_content(@shelter.name)
            expect(page).to_not have_content(@shelter2.name)
        end
    end
end