class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method(
    :current_user,
    :log_in,
    :logged_in,
    :log_out,
    :already_logged_in,
    :owner
  )

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def already_logged_in
    # debugger
    if logged_in?
      redirect_to cats_url
    end
  end

  def owner
    debugger
    cats = current_user.cats.where(id: current_cat.id)
    if cats.empty?
      flash[:errors] = ["STOP FOOLING!"]
      redirect_to cat_url(current_cat)
    end
  end


end
