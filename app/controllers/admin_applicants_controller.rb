class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
    end
end