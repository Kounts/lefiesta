class CustomFailure < Devise::FailureApp

    # You need to override respond to eliminate recall
    def respond
      if http_auth?
        http_auth
      else
        redirect_to root_path, alert: "Invalid login or password"
      end
    end
  end