require 'rails_helper'

RSpec.describe 'applicants show page' do
    before :each do
        @john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
        @jane = Applicant.create!(name: 'Jane Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
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
        within 'div#address' do
            expect(page).to have_content(@john.street)
            expect(page).to have_content(@john.city)
            expect(page).to have_content(@john.state)
            expect(page).to have_content(@john.zip)
        end
        expect(page).to have_content(@john.personal_statement)
        within 'p#status' do
            expect(page).to have_content('Application Status: In Progress')
        end
    end

    it 'lists all pets being applied for as links to their show pages' do
        visit "/applicants/#{@john.id}"

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)

        expect(page).to have_link(href: "/pets/#{@pet1.id}")
        expect(page).to have_link(href: "/pets/#{@pet2.id}")
    end

    describe 'when application is not yet submitted you can add new pets by name' do
        it 'search for pet by name' do
            visit "/applicants/#{@john.id}"

            fill_in :name, with: 'B'
            click_button 'Submit'

            expect(current_path).to eq("/applicants/#{@john.id}")
            within "div#potential_pets" do
                expect(page).to_not have_content(@pet2.name)
                expect(page).to have_content(@pet3.name)
            end
        end

        it 'returns flash error if no pets match search' do
            visit "/applicants/#{@john.id}"

            fill_in :name, with: 'Pete Barker'
            click_button 'Submit'

            expect(current_path).to eq("/applicants/#{@john.id}")
            expect(page).to_not have_content(@pet3.name)
            expect(page).to have_content("New pet with name 'Pete Barker' not found.")
        end

        it 'has button to add pet' do
            visit "/applicants/#{@john.id}"

            fill_in :name, with: 'Peter Barker'
            click_button 'Submit'

            click_button 'Adopt this Pet'

            expect(current_path).to eq("/applicants/#{@john.id}")
            expect(page).to have_link(href: "/pets/#{@pet3.id}")
        end
    end

    describe 'submitting an application' do
        it 'must have pets to be submittable' do
            visit "/applicants/#{@jane.id}"

            expect(page).to_not have_button('Submit Application')

            fill_in :name, with: 'Peter Barker'
            click_button 'Submit'

            click_button 'Adopt this Pet'

            expect(page).to have_button('Submit Application')
        end

        it 'once it is submitted it shows all desired pets and no more can be added' do
            visit "/applicants/#{@john.id}"

            click_button 'Submit Application'

            expect(current_path).to eq("/applicants/#{@john.id}")
            expect(page).to have_content(@pet1.name)
            expect(page).to have_content(@pet2.name)
            expect(page).to_not have_button('Submit Application')
            within '#status' do
                expect(page).to have_content('Application Status: Pending')
            end
        end
    end
end