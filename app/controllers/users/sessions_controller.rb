class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.persisted?
      sign_in(resource_name, resource)
      render json: { success: true, user: resource }, status: :ok
    else
      render json: { success: false, error: "Invalid login credentials" }, status: :unauthorized
    end
  end

  def destroy
    super # or your custom logic
  end
end
