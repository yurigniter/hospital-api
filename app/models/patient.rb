class Patient < ApplicationRecord
    validates_presence_of :first_name, :last_name, :birthdate, :address
    has_many :medical_histories, dependent: :destroy
end