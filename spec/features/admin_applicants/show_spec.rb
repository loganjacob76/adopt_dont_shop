require 'rails_helper'

RSpec.describe 'admin applicant show page' do
    before :each do
        @john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
        @shelter1 = Shelter.create!(foster_program: true, name: 'Paws of Life', city: 'Denver', rank: 3)
        @pet1 = @shelter1.pets.create!(adoptable: true, age: 1, breed: 'Labrador', name: 'Star')
        @pet2 = @shelter1.pets.create!(adoptable: true, age: 4, breed: 'Mutt', name: 'Boo')

        AdoptionApplication.create!(applicant_id: @john.id, pet_id: @pet1.id)
        AdoptionApplication.create!(applicant_id: @john.id, pet_id: @pet2.id)
    end

    it 'has buttons to approve or reject each pet' do
        visit "/admin/applicants/#{@john.id}"

        within 'div#Star' do
            expect(page).to have_button('Approve Application')
            expect(page).to have_button('Reject Application')
        end

        within 'div#Boo' do
            expect(page).to have_button('Approve Application')
            expect(page).to have_button('Reject Application')
        end
    end

    it 'can accept application' do
        visit "/admin/applicants/#{@john.id}"

        within 'div#Star' do
            click_button 'Approve Application'
        end
        
        expect(current_path).to eq("/admin/applicants/#{@john.id}")

        within 'div#Star' do
            expect(page).to_not have_button('Approve Application')
            expect(page).to_not have_button('Reject Application')

            expect(page).to have_content('Status: Approved')
        end
    end
end