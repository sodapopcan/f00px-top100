module PagerHelper
  def paginate(total, current)
    elements = (1..total).map do |page|
      if page == current
        content_tag :div, content_tag(:span, page), class: 'page current control'
      else
        content_tag :div, link_to(page, root_path(page: page)), class: 'page control'
      end
    end

    elements.join("\n").html_safe
  end
end
