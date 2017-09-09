class Api::LittleBrotherChipsController < ApplicationController

    def index
        little_brother_chips = LittleBrotherChip.all

        render_records little_brother_chips
    end

    def show
        little_brother_chip = LittleBrotherChip.find params[:id]

        render_response little_brother_chip, displayable_keys
    end

    def update
        little_brother_chip = LittleBrotherChip.find params[:id]
        little_brother_chip.assign_attributes little_brother_chip_params

        little_brother_chip.save ?
            render_204
            : render_error(little_brother_chip)
    end

    def destroy
        LittleBrotherChip.find(params[:id]).destroy

        render_204
    end

    def create
        little_brother_chip = LittleBrotherChip.new little_brother_chip_params

        little_brother_chip.save ?
            render_response(little_brother_chip, displayable_keys)
            : render_error(little_brother_chip)
    end

    private
        def little_brother_chip_params
            params.require(:little_brother_chip).permit :user_id
        end

        def displayable_keys
            %w(user_id)
        end

end
