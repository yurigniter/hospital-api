module Api
    module V1
        class PatientsController < ApplicationController
            before_action :set_patient, only: [:show, :update, :destroy]

            def index
                patients = Patient.all;
                render json: patients
            end
        
            def show
                render json: @patient
            end
    
            def create
                patient = Patient.new(patient_params)
        
                if patient.save
                    render json: patient, status: :created
                else
                    render json: patient.errors, status: :unprocessable_entity
                end
            end
    
            def update
                if @patient.update_attributes(patient_params)
                    render json: @patient, status: :ok
                else
                    render json: @patient.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @patient.destroy
                render json: @patient
            end
    
            private

            def patient_params
              params.permit(:first_name, :middle_name, :last_name, :birthdate, :gender, :address)
            end

            def set_patient
                @patient = Patient.find(params[:id])
            end
        end
    end
end