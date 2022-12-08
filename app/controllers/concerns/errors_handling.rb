module ErrorsHandling

    extend ActiveSupport::Concern
        included do
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

        private

        def record_not_found
            render file: "public/404.html", status: :not_found, layout: false
        end
    end
end