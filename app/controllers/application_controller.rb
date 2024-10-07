class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pagy::Backend
  include SessionsHelper
end
