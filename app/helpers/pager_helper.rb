module PagerHelper
  def paginate(total, current)
    elements = (1..total).map do |page|
      if page == current
        content_tag :div, page, class: 'page current'
      else
        content_tag :div, link_to(page, root_path(page: page)), class: 'page current'
      end
    end

    elements.join("\n").html_safe
  end
end
