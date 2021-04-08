class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
        binding.pry
    end
end