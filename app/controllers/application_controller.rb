class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

      def render_response(model, displayable_keys)
          render json: model.attributes.select{|k,v| k.in? displayable_keys}
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
