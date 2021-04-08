class ApplicantsController < ApplicationController
    def index
        @applicants = Applicant.all
    end

    def show
        @applicant = Applicant.find(params[:id])
        
        if params[:pet_name]
            @pets = []
            potential_pets = Pet.search(params[:pet_name])
            
            potential_pets.each do |pet|
                @pets << pet if !@applicant.pets.include?(pet)
            end

            flash[:error] = "New pet with name '#{params[:pet_name]}' not found." if @pets == []
        end
    end

    def new
    end

    def create
        applicant = Applicant.new(applicant_params)
        if applicant.save
            redirect_to "/applicants/#{applicant.id}"
        else
            flash[:error] = error_message(applicant.errors)
            render :new
        end
    end

    def add
        applicant = Applicant.find(params[:id])
        pet = Pet.find(params[:pet_id])
        AdoptionApplication.create!(applicant: applicant, pet: pet)

        redirect_to "/applicants/#{applicant.id}"
    end

    def submit
        applicant = Applicant.find(params[:id])
        applicant.update!(status: 'Pending')

        redirect_to "/applicants/#{applicant.id}"
    end

    private
        def applicant_params
            params.permit(:name, :street, :city, :state, :zip)
        end
end