module WamblZendesk
  module Requester

    require 'wambl_zendesk/response'

    require 'uri'
    require 'net/http'
    require 'net/https'
    require 'json'

    class << self
      def get _path, _params = {}

        a = Time.now

        uri = URI.parse("https://#{WamblZendesk.config.subdomain}.zendesk.com#{_path}")

        new_path = uri.path
        query_sets = []
        query_sets << uri.query
        query_sets << _params.to_query
        new_path << "?" if query_sets.count > 0
        new_path << query_sets.join('&')

        http = Net::HTTP.new(WamblZendesk.config.uri.host,WamblZendesk.config.uri.port)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.use_ssl = WamblZendesk.config.uri.scheme == 'https'

        request = "Net::HTTP::#{__callee__.to_s.camelize}".constantize.new(new_path)
        request.basic_auth("#{WamblZendesk.config.email}/token",WamblZendesk.config.token)
        response = http.request(request)

        Response.new(response,a)

      end
      alias :post :get
      alias :put :get
      alias :delete :get
    end

  end
end
