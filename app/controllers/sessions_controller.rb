class SessionsController < Devise::SessionsController
    respond_to :json
  
    # Custom actions
    def create
      super # or your custom logic
    end
  
    def destroy
      super # or your custom logic
    end
  end
  