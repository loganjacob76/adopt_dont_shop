require 'rails_helper'

RSpec.describe 'applicants show page' do
    before :each do
        @john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
        @shelter1 = Shelter.create!(foster_program: true, name: 'Paws of Life', city: 'Denver', rank: 3)
        @pet1 = @shelter1.pets.create!(adoptable: true, age: 1, breed: 'Labrador', name: 'Star')
        @pet2 = @shelter1.pets.create!(adoptable: true, age: 4, breed: 'Mutt', name: 'Boo')
        @pet3 = @shelter1.pets.create!(adoptable: true, age: 6, breed: 'Border Collie', name: 'Peter Barker')

        AdoptionApplication.create!(applicant_id: @john.id, pet_id: @pet1.id)
        AdoptionApplication.create!(applicant_id: @john.id, pet_id: @pet2.id)
    end

    it 'has all applicant information' do
        visit "/applicants/#{@john.id}"

        expect(page).to have_content(@john.name)
        expect(page).to have_content(@john.street)
        expect(page).to have_content(@john.city)
        expect(page).to have_content(@john.state)
        expect(page).to have_content(@john.zip)
        expect(page).to have_content(@john.personal_statement)
        expect(page).to have_content(@john.status)
    end

    it 'lists all pets being applied for as links to their show pages' do
        visit "/applicants/#{@john.id}"

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)

        expect(page).to have_link(href: "/pets/#{@pet1.id}")
        expect(page).to have_link(href: "/pets/#{@pet2.id}")
    end

    describe 'when application is not yet submitted you can add pets by name' do
        it 'search for pet by name' do
            visit "/applicants/#{@john.id}"

            fill_in :name, with: 'Peter Barker'
            click_button 'Submit'

            expect(current_path).to eq("/applicants/#{@john.id}")
            expect(page).to have_content(@pet3.name)
        end
    end
end