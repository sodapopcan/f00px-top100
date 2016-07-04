class ApiClient
  attr_reader :http

  def initialize(base_url, default_query_params: {})
    @default_query_params = default_query_params
    @http = Excon.new(base_url, debug: Settings.api.debug)
  end

  def get(query = {})
    request('get', query: query)
  end

  private

  def request(meth, query: {})
    response = @http.request(
      method: meth,
      query: q(query)
    )
    MultiJson.load(response.body, symbolize_keys: true)
  end

  def q(query)
    query.merge(@default_query_params)
  end
end
