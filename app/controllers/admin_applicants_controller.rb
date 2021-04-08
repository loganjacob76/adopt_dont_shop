class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
    end
    
    def update
        binding.pry
    end
end