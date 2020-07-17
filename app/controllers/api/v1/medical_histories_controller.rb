module Api
    module V1
        class MedicalHistoriesController < ApplicationController
            before_action :set_patient
            before_action :set_patient_medical_history, only: [:show, :update, :destroy]

            def index
                render json: @patient.medical_histories
            end
        
            def show
                render json: @medicalHistory
            end
    
            def create
                medicalHistory = @patient.medical_histories.new(medical_history_params)
                if medicalHistory.save
                    render json: medicalHistory, status: :created
                else
                    render json: medicalHistory.errors, status: :unprocessable_entity
                end
            end
    
            def update
                if @medicalHistory.update_attributes(medical_history_params)
                    render json: @medicalHistory, status: :ok
                else
                    render json: @medicalHistory.errors, status: :unprocessable_entity
                end
            end
    
            def destroy
                @medicalHistory.destroy
                render json: @medicalHistory
            end

            private

            def medical_history_params
              params.permit(:date, :details, :patient_id)
            end

            def set_patient
                @patient = Patient.find(params[:patient_id])
            end

            def set_patient_medical_history
                @medicalHistory = @patient.medical_histories.find_by!(id: params[:id]) if @patient
            end
        end
    end
end