class HomeController < ApplicationController
  def index
    resp = PhotoService.top100
    @page = resp.current_page
    @total_pages = resp.total_pages
    @photos = resp.photos
  end
end
