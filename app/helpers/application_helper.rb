module ApplicationHelper
    include Pagy::Frontend

    def full_title page_title
        base_title = "AskIt"
        if page_title.present?
            base_title = "AskIt|#{page_title}"
        else
            base_title
        end
    end

    def currently_at(current_page="")
        render partial: "shared/menu"
    end

    def nav_tab(title, url, options={})
        current_page = options.delete :current_page
        css_class = current_page == title ? "bold" : "text-white"
        options[:class] = if options[:class]
                                options[:class] + " " + css_class
                            else
                                css_class
                            end
        link_to title url options
    end

    def pagination(obj)
        raw(pagy_nav(obj)) if obj.pages > 1
    end

end
