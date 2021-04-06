class Applicant < ApplicationRecord
    has_many :adoption_applications, dependent: :destroy
    has_many :pets, through: :adoption_applications

    validates :name, presence: true, uniqueness: true
    validates :street, presence: true
    validates :city, presence: true 
    validates :state, presence: true, length: {maximum: 2}
    validates :zip, numericality: true 
end