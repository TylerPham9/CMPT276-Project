module ApplicationHelper
  # Returns the full title on a per-page basis.
    def full_title(page_title = '')
      base_title = "DrawParty"
      if page_title.empty?
        base_title
      else
        page_title + " | " + base_title
      end
    end


    def is_active?(page_name)
  "active" if params[:action] == page_name
  end
end
