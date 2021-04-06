require 'rails_helper'

RSpec.describe 'applicants index page' do
    before :each do
        @john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
        @jane = Applicant.create!(name: 'Jane Doe', street: '5678 Fake Ave.', city: 'Tampa', state: 'FL', zip: 67890, personal_statement: 'I have a large yard, plenty of emergency funds, and lots of free time to spend training and playing.')
    end

    it 'has lists all applicants' do
        visit '/applicants'

        expect(page).to have_content(@john.name)
        expect(page).to have_content(@jane.name)
    end

    it 'names are links to the applicant show pages' do
        visit '/applicants'

        expect(page).to have_link(href: "/applicants/#{@john.id}")
        expect(page).to have_link(href: "/applicants/#{@jane.id}")
    end
end