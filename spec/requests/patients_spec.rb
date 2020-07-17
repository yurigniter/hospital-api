require 'rails_helper'
require 'httparty'

class TestPatient
    include HTTParty
    base_uri "http://localhost:3000/api/v1/"
end

describe "Patient:" do
    patient_id = 1

    it "show all patients" do
        response = TestPatient.get("/patients")
        expect(response.code).to eql(200) # Ok
        expect(JSON.parse(response.body).size).to eq(5) # Total number of result
    end

    it "show specific patient" do
        response = TestPatient.get("/patients/#{patient_id}")
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["id"]).to match(patient_id) 
    end

    it "create patient successfully" do
        response = TestPatient.post("/patients/", body: {
            first_name: "Yuri",
            middle_name: "Im",
            last_name: "Kwon",
            birthdate: "1994-01-01",
            gender: "Female",
            address: "Seoul, South Korea"
        })
        expect(response.code).to eql(201) # Created
        expect(response.parsed_response["first_name"]).to match("Yuri")
        expect(response.parsed_response["middle_name"]).to match("Im")
        expect(response.parsed_response["last_name"]).to match("Kwon")
        expect(response.parsed_response["birthdate"]).to match("1994-01-01")
        expect(response.parsed_response["gender"]).to match("Female")
        expect(response.parsed_response["address"]).to match("Seoul, South Korea")
    end

    it "create patient NOT successfully" do
        response = TestPatient.post("/patients/", body: {
            gender: "Female",
        })
        expect(response.code).to eql(422) # Unprocessable_entity
        expect(response.parsed_response).to eq({
            "first_name" => ["can't be blank"],
            "last_name" => ["can't be blank"],
            "birthdate" => ["can't be blank"],
            "address" => ["can't be blank"]
        })
    end

    it "updates patient information" do
        response = TestPatient.put("/patients/#{patient_id}", body: {
            last_name: "Kim",
            address: "Cebu, Philippines"
        })
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["id"]).to match(1)
        expect(response.parsed_response["last_name"]).to match("Kim")
        expect(response.parsed_response["address"]).to match("Cebu, Philippines")
    end

    it "deletes patient information" do
        response = TestPatient.delete("/patients/5")
        expect(response.code).to eql(200) # Ok
        expect(response.parsed_response["id"]).to match(5)
    end

end