# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do
    patient = Patient.create({
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.middle_name,
        last_name: Faker::Name.last_name,
        birthdate: Faker::Date.between(from: '1980-01-01', to: '1995-01-01'),
        gender: Faker::Gender.binary_type,
        address: Faker::Address.full_address
    });

    2.times do
        patient.medical_histories.create({
            date: Faker::Date.between(from: '2000-01-01', to: '2019-01-01'),
            details: Faker::Lorem.sentence # Details why the patient visited the hospital
        });
    end
end