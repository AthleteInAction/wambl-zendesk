module WamblZendesk
  class Resource < OpenStruct

    def self.object_name
      self.name.split('::').last.singularize.underscore
    end

    def self.find id
      _request = self.request(path: "/#{id}")
      if _request.code == 200
        self.new(_request.json[self.object_name])
      else
        nil
      end
    end

    def self.find! id
      _request = self.request(path: "/#{id}")
      case _request.code
      when 200
        self.new(_request.json[self.object_name])
      when 404
        raise "#{self.object_name.humanize} not found"
      else
        raise "#{self.object_name.humanize} request failed: #{request.code}"
      end
    end

    def initialize _json
      _json.each do |key,val|
        _json[key] = DateTime.parse(val) if key.include?("_at")
      end
      super(_json)
    end

    def self.request _params = {}
      params = _params.dup
      params.delete :path
      params.delete 'path'
      WamblZendesk::Requester.get("/api/v2/#{self.object_name.pluralize}#{_params[:path] || _params['path']}",params)
    end


    def self.page _page = 1
      _request = self.request
      if _request.code == 200
        groups = _request.json[self.object_name.pluralize.underscore].map { |json| self.new(json) }
        if block_given?
          groups.each { |group| yield(group) }
          return
        else
          return groups
        end
      end
      raise "Failed to get page (#{_page}): #{_request.code}"
    end

  end
end
