require 'rails_helper'

RSpec.describe AdoptionApplication do
    describe 'attributes' do
        it { should belong_to :applicant}
        it { should belong_to :pet}
    end
end