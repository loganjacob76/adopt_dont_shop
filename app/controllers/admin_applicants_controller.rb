class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
    end
    
    def update
        applicant = Applicant.find(params[:id])
        pet = Pet.find(params[:pet_id])        
        application = AdoptionApplication.find_by(applicant: applicant, pet: pet)
        
        application.update!(application_status: params[:application_status])
        redirect_to "/admin/applicants/#{applicant.id}"
    end
end