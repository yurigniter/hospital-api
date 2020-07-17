require 'rails_helper'
require 'httparty'

class TestMedicalHistory
    include HTTParty
    base_uri "http://localhost:3000/api/v1/"
end

describe "Medical History:" do
    medical_history_id = 1
    patient_id = 1

    it "show all medical history of patient" do
        response = TestMedicalHistory.get("/patients/#{patient_id}/medical_histories")
        expect(response.code).to eql(200) # Ok
        expect(JSON.parse(response.body).size).to eq(2) # Total number of result
    end

    it "show specific patient's medical history" do
        response = TestMedicalHistory.get("/patients/#{patient_id}/medical_histories/#{medical_history_id}")
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["id"]).to match(medical_history_id)
    end

    it "create patient's medical history successfully" do
        response = TestMedicalHistory.post("/patients/#{patient_id}/medical_histories", body: {
            date: "2020-05-03",
            details: "Fever"
        })
        expect(response.code).to eql(201) # Created
        expect(response.parsed_response["date"]).to match("2020-05-03")
        expect(response.parsed_response["details"]).to match("Fever")
    end

    it "create patient's medical history NOT successfully" do
        response = TestMedicalHistory.post("/patients/#{patient_id}/medical_histories", body: {
            date: "2020-05-03"
        })
        expect(response.code).to eql(422) # Unprocessable_entity
        expect(response.parsed_response).to eq({
            "details" => ["can't be blank"],
        })
    end

    it "updates patient's medical history" do
        response = TestMedicalHistory.put("/patients/#{patient_id}/medical_histories/#{medical_history_id}", body: {
            details: "Headache"
        })
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["details"]).to match("Headache")
    end

    it "deletes patient's medical history" do
        response = TestMedicalHistory.delete("/patients/#{patient_id}/medical_histories/#{medical_history_id}")
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["id"]).to match(medical_history_id)
    end
end