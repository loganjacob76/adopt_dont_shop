class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :adoption_applications
  has_many :applicants, through: :adoption_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
