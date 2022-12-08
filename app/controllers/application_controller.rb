class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ErrorsHandling
    include Authentication
end
