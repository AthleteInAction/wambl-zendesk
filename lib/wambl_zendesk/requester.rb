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

        if __callee__.to_s.downcase == "get"
          query_sets = []
          query_sets << uri.query
          query_sets << _params.to_query
          new_path << "?" if query_sets.count > 0
          new_path << query_sets.join('&')
        end

        http = Net::HTTP.new(WamblZendesk.config.uri.host,WamblZendesk.config.uri.port)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        http.use_ssl = WamblZendesk.config.uri.scheme == 'https'

        request = "Net::HTTP::#{__callee__.to_s.camelize}".constantize.new(new_path)
        if ["post","put"].include?(__callee__.to_s.downcase)
          if new_path.include?('upload') || new_path.include?('/attachments')
            request.content_type = 'application/*'
            request.body = _params
          else
            request.content_type = 'application/json'
            request.body = _params.to_json
          end
        end
        request.basic_auth("#{WamblZendesk.config.email}/token",WamblZendesk.config.token)
        response = http.request(request)

        Response.new(response,a)

      end
      alias :post :get
      alias :put :get
      alias :delete :get
    end

    def get _path, _params = {}

      a = Time.now

      uri = URI.parse("https://#{self.config.subdomain}.zendesk.com#{_path}")

      new_path = uri.path

      if __callee__.to_s.downcase == "get" || new_path.include?("upload")
        query_sets = []
        query_sets << uri.query if uri.query
        query_sets << _params.to_query if !new_path.include?("upload") && _params.count > 0
        if query_sets.count > 0
          new_path << "?"
          new_path << query_sets.join('&')
        end
      end

      http = Net::HTTP.new(self.config.uri.host,self.config.uri.port)
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = self.config.uri.scheme == 'https'

      request = "Net::HTTP::#{__callee__.to_s.camelize}".constantize.new(new_path)
      if ["post","put"].include?(__callee__.to_s.downcase)
        if new_path.include?('upload') || new_path.include?('/attachments')
          request.content_type = 'application/*'
          request.body = _params
        else
          request.content_type = 'application/json'
          request.body = _params.to_json
        end
      end
      request.basic_auth("#{self.config.email}/token",self.config.token)
      response = http.request(request)

      Response.new(response,a)

    end

  end
end
