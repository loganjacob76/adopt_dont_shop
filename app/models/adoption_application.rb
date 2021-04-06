class AdoptionApplication < ApplicationRecord
    belongs_to :applicant
    belongs_to :pet
end