module WamblZendesk
  module Loops

    def next_get _path
      meta = { count: 0 }
      while _path
        request = self.get(_path)
        raise "Request failed: #{_path} -> #{request.code}".red if request.code != 200
        params = path_to_query_hash(_path)
        meta[:page] = params['page'].try(:presence) || 1
        meta[:total] = request.json['count']
        meta[:path] = _path
        request.json[request.json.keys.first].each do |json|
          meta[:count] += 1
          yield(json, meta)
        end
        break if request.json['count'] < 1000
        _path = url_to_next_path(request.json['next_page'])
      end
    end

    private
    def path_to_query_hash _path
      uri = URI.parse(_path)
      Rack::Utils.parse_nested_query(uri.query)
    end
    def url_to_next_path _url
      return nil if !_url.try(:presence)
      uri = URI.parse(_url)
      next_path = uri.path
      next_path << "?#{uri.query}" if uri.query.try(:presence)
    end

  end
end
