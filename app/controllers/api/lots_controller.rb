class Api::LotsController < ApplicationController

    def index
        lots = Lot.all

        render_records lots
    end

    def show
        lot = Lot.find params[:id]

        render_response lot, displayable_keys
    end

    def update
        lot = Lot.find params[:id]
        lot.assign_attributes lot_params

        lot.save ?
            render_204
            : render_error(lot)
    end

    def destroy
        Lot.find(params[:id]).destroy

        render_204
    end

    def create
        lot = Lot.new lot_params

        lot.save ?
            render_response(lot, displayable_keys)
            : render_error(lot)
    end

    private
        def lot_params
            params.require(:lot).permit :building_id, :lot_type, :name, :floor_level, :dimensions
        end

        def displayable_keys
            %w(building_id lot_type name floor_level dimensions)
        end

end
