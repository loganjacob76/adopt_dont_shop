require 'rails_helper'

RSpec.describe 'new application form' do
    describe 'as a visitor' do
        describe 'when i visit the new application form by clicking a link on the pets index' do
            it 'can create a new applicant' do
                visit '/pets'

                click_link 'Start An Application'
                expect(current_path).to eq('/applicants/new')

                fill_in :name, with: 'Derrick Henry'
                fill_in :street, with: '1 Titans Way'
                fill_in :city, with: 'Nashville'
                fill_in :state, with: 'TN'
                fill_in :zip, with: 37213
                click_on 'Submit'

                henry = Applicant.find_by(name: 'Derrick Henry')
                
                expect(current_path).to eq("/applicants/#{henry.id}")
                expect(page).to have_content(henry.name)
                expect(page).to have_content(henry.street)
                expect(page).to have_content(henry.city)
                expect(page).to have_content(henry.state)
                expect(page).to have_content(henry.zip)
                expect(page).to have_content('In Progress')
            end
        end
    end
end