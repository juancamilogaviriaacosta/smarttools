class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
<<<<<<< HEAD
  protect_from_forgery with: :exception
  include SessionHelper
=======
  #protect_from_forgery with: :exception
>>>>>>> parent of 7fbb8b6... Se agregan los demas casos de uso
end
