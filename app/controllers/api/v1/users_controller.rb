module API
  module V1
    class UsersController < ApplicationController
      
      def index
        data = "Hello API"
        render json: {data: data}, status: :ok
      end
      
      def create
        @user = User.new(user_params)
        if @user.save
          @user.remember
          render json: { message: "success create user", data: @user }, status: :ok
        else
          render json: { message: "fail to create new user" }, status: :nok
        end
      end
      
      
      private
        def user_params
          params.permit(:name, :email, :linkedin_id)
        end
      
    end
  end
end