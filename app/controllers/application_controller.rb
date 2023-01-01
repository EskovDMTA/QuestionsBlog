class ApplicationController < ActionController::Base
    include Authorization
    include Pagy::Backend
    include ErrorsHandling
    include Authentication
end
