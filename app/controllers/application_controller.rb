class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def sign_in(*args)
    super(*args)
    # store unencrypted pass in session for encode/decode
    session[:master_key] = params[:user]['password']
  end
end
