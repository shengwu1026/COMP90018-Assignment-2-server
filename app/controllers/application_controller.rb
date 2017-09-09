class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

        def render_records(models, displayable_keys)
            render json: models.map{|m|
                displayable_keys.map{|k| [k, m.send(k.to_sym)]}.to_h }
        end

        def render_response(model, displayable_keys)
            render json: displayable_keys.map{|k| [k,model.send(k.to_sym)]}.to_h
        end

        def render_error(model)
            render json: { errors: model.errors.full_messages }, status: 422
        end

        def record_not_found
            render json: { errors: ['Record not found.'] }, status: :not_found
        end

        # 204 response
        def render_204
            head :no_content
        end
end
