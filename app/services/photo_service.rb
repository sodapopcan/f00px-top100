# Service module for making photo-related API class.
# Returns a Reponse object containing the current page, total pages,
# and an array of Photo instances (see app/models/photo)
module PhotoService
  extend self

  Response = Struct.new(:current_page, :total_pages, :photos)

  def top100(page = 1)
    parse_response api.get(feature: 'popular',
                           sort: 'rating',
                           image_size: 3,
                           include_store: 'store_download',
                           include_states: 'voted',
                           page: page), 5
  end

  private

  def api
    @api ||= ApiClient.new(
      [Settings.api.base_url, '/photos'].join,
      default_query_params: { consumer_key: Settings.api.consumer_key }
    )
  end

  def parse_response(response, total_pages = nil)
    Response.new(
      response[:current_page],
      total_pages || response[:total_pages],
      response[:photos].map { |p| Photo.new(p) }
    )
  end
end
