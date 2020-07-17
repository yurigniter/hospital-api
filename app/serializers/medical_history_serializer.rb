class MedicalHistorySerializer < ActiveModel::Serializer
  attributes :id, :date, :details
end
