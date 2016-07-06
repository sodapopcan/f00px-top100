class HomeController < ApplicationController
  helper :pager

  def index
    resp = PhotoService.top100(params['page'] || 1)
    @current_page = resp.current_page
    @total_pages = resp.total_pages
    @photos = resp.photos
  end
end
