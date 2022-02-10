class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :error
  
end
