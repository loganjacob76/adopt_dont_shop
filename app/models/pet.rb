class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :adoption_applications, dependent: :destroy
  has_many :applicants, through: :adoption_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def adoption_application_status(applicant)
    AdoptionApplication.find_by(applicant_id: applicant.id, pet_id: self.id).application_status
  end
end
