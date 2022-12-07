class ApplicationController < ActionController::Base
  def fetch_or_create_user
    current_user ||
      sign_in(
        User.create(
          email: "#{SecureRandom.uuid}@tmp.com",
          password: SecureRandom.hex
        )
      )
  end
end
