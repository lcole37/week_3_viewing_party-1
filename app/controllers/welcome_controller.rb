class WelcomeController < ApplicationController
    def index
      # unless cookies[:greeting]
      #   cookies[:greeting] = "Hello"
      # end
        @users = User.all
    end
end
