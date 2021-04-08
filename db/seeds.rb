# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Applicant.destroy_all

shelter1 = Shelter.create!(foster_program: true, name: 'Paws of Life', city: 'Denver', rank: 3)
shelter2 = Shelter.create!(foster_program: false, name: 'Pets R Us', city: 'Tampa', rank: 9)

pet1 = shelter1.pets.create!(adoptable: true, age: 1, breed: 'Labrador', name: 'Star')
pet2 = shelter1.pets.create!(adoptable: false, age: 4, breed: 'Mutt', name: 'Boo')
pet3 = shelter2.pets.create!(adoptable: true, age: 2, breed: 'Bulldog', name: 'Zeke')
pet4 = shelter2.pets.create!(adoptable: true, age: 3, breed: 'Great Dane', name: 'Benny')

vet_office1 = VeterinaryOffice.create!(boarding_services: false, max_patient_capacity: 8, name: 'Fur Clinic')
vet_office2 = VeterinaryOffice.create!(boarding_services: true, max_patient_capacity: 20, name: 'Pet Doctors')

vet1 = vet_office1.veterinarians.create!(on_call: true, review_rating: 4, name: 'Joe Schmoe')
vet2 = vet_office2.veterinarians.create!(on_call: false, review_rating: 5, name: 'Jane Schmoe')

john = Applicant.create!(name: 'John Doe', street: '1234 Example Dr.', city: 'Denver', state: 'CO', zip: 12345, personal_statement: 'I love animals and live next to a park.')
jane = Applicant.create!(name: 'Jane Doe', street: '5678 Fake Ave.', city: 'Tampa', state: 'FL', zip: 67890, personal_statement: 'I have a large yard, plenty of emergency funds, and lots of free time to spend training and playing.')

AdoptionApplication.create!(applicant_id: john.id, pet_id: pet1.id)
AdoptionApplication.create!(applicant_id: jane.id, pet_id: pet3.id)