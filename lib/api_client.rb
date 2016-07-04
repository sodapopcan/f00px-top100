class ApiClient
  def initialize(base_url)
    @base_url = base_url
  end

  def get(path, query = {})
    request(:get, path, query)
  end

  private

  def request(meth, path, body = {})
    response = Excon.send(meth, [@base_url, path].join('/'), body)
    MultiJson.load(response.body, symbolize_keys: true)
  end
end
