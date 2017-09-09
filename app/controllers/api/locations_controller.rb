class Api::LocationsController < ApplicationController

    def index
        locations = Location.all

        render_records locations, displayable_keys
    end

    def show
        location = Location.find params[:id]

        render_response location, displayable_keys
    end

    def update
        location = Location.find params[:id]
        location.assign_attributes location_params

        location.save ?
            render_204
            : render_error(location)
    end

    def destroy
        Location.find(params[:id]).destroy

        render_204
    end

    def create
        location = Location.new location_params

        location.save ?
            render_response(location, displayable_keys)
            : render_error(location)
    end

    private
        def location_params
            params.require(:location).permit :little_brother_chip_id, :lot_id, :coordinates
        end

        def displayable_keys
            %w(little_brother_chip_id lot_id coordinates)
        end

end
