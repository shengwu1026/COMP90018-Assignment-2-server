class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        # render a very big json
        render html: "<pre>#{JSON.pretty_generate(
            users: User.all.map{|u| u.attributes},
            little_brother_chips: LittleBrotherChip.all.map{|l| l.attributes},
            buildings: Building.all.map{|b| b.attributes},
            lots: Lot.all.map{|l| l.attributes},
            beacons: Beacon.all.map{|b| b.attributes},
            locations: Location.all.map{|l| l.attributes}
        )}</pre>".html_safe
    end
    
    private

        def render_records(models)
            # render json: models.map{|m|
            #     displayable_keys.map{|k| [k, m.send(k.to_sym)]}.to_h }
            render json: models
        end

        def render_response(model, displayable_keys)
            render json: displayable_keys.map{|k| [k,model.send(k.to_sym)]}.to_h
        end

        def render_error(model)
            render json: { errors: model.errors.full_messages }, status: 422
        end

        def render_error_message(raised_error)
            render json: { errors: raised_error.message }, status: 422
        end

        def record_not_found
            render json: { errors: ['Record not found.'] }, status: :not_found
        end

        def record_not_found(model_name)
            render json: { errors: ["#{model_name} not found."] }, status: :not_found
        end

        # 204 response
        def render_204
            head :no_content
        end
end
