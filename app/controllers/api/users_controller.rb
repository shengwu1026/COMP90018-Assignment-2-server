class Api::UsersController < ApplicationController
    def show
        u = User.new(first_name: 'John', last_name: 'Doe', username: 'johndoe')

        render_response u
    end

    def update
    end

    def destroy
    end

    def create
        u = User.new(user_params)

        render_response u
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :password, :username)
        end

        def render_response(user)
            render json: user.attributes.select{|k,v| k.in? %w(first_name last_name username)}
        end
end
