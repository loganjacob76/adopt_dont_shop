class AdminSheltersController < ApplicationController
    def index
        @shelters = Shelter.reverse_alphabetical
        @pending_shelters = Shelter.pending_shelters
    end
end