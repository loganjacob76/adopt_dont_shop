class ApplicantsController < ApplicationController
    def index
        @applicants = Applicant.all
    end

    def show
        @applicant = Applicant.find(params[:id])
    end

    def new
    end

    def create
        applicant = Applicant.new(applicant_params)
        if applicant.save
            redirect_to "/applicants/#{applicant.id}"
        else
            flash[:error] = applicant.errors.full_messages.to_sentence
            render :new
        end
    end

    private
        def applicant_params
            params.permit(:name, :street, :city, :state, :zip)
        end
end