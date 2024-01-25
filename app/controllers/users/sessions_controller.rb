# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  # Signs in a user with valid credentials and returns an authentication token.
  #
  # Behavior:
  # - Authenticates the user using the provided credentials (email and password).
  # - If authentication is successful, signs in the user and generates a JSON web token (JWT).
  # - Responds with a JSON object containing the user information and the generated token.
  # - If authentication fails, responds with a JSON object indicating an unauthorized access.
  #
  # Params:
  # - `email` (string): The email of the user trying to log in.
  # - `password` (string): The password of the user trying to log in.
  #
  # Response (Success):
  # {
  #   "success": true,
  #   "user": {
  #     "id": 1,
  #     "email": "user@example.com",
  #     "created_at": "2022-01-25T12:00:00.000Z",
  #     "updated_at": "2022-01-25T12:00:00.000Z"
  #   },
  #   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2NjEyMjMxNTl9.5YkZmC0vVL"
  # }
  #
  # Response (Failure - Unauthorized):
  # {
  #   "success": false,
  #   "error": "Invalid login credentials"
  # }
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.persisted?
      sign_in(resource_name, resource)
      token = JWT.encode({ user_id: resource.id }, ENV['SECRET_KEY_BASE'], 'HS256')
      render json: { success: true, user: resource, token: token }, status: :ok
    else
      render json: { success: false, error: "Invalid login credentials" }, status: :unauthorized
    end
  end

  # DELETE /users/sign_out
  # Signs out the currently signed-in user and clears the session.
  #
  # Behavior:
  # - Clears the user's session and signs them out.
  # - Deletes the user's session cookie.
  # - Responds with a JSON object indicating a successful sign-out.
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

  # Overrides the flash method to prevent Devise from using flash messages
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
