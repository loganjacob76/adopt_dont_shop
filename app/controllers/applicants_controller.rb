class ApplicantsController < ApplicationController
    def index
        @applicants = Applicant.all
    end

    def show
        binding.pry
    end
end