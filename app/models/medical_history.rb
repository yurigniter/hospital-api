class MedicalHistory < ApplicationRecord
    validates_presence_of :date, :details
    belongs_to :patient
end
