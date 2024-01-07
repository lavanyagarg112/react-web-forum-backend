class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.persisted?
      sign_in(resource_name, resource)
      puts "signedin"
      render json: { success: true, user: resource }, status: :ok
    else
      render json: { success: false, error: "Invalid login credentials" }, status: :unauthorized
    end
  end


  def destroy
    reset_session
    sign_out current_user
    cookies.delete('_my_unique_app_session')
    puts "signed out"
    render json: { success: true }
  end

  private

  # Override to prevent Devise from using flash messages
  def set_flash_message!(*)
    # No operation
  end

  def flash
    @flash ||= Hash.new.tap do |fl|
      def fl.[]=(*)
      end

      def fl.now
        self
      end
    end
  end


end
