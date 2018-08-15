module WamblZendesk
  class Response

    attr_reader :code
    attr_reader :json
    attr_reader :limit
    attr_reader :remaining
    attr_reader :body
    attr_reader :either
    attr_reader :time
    attr_reader :headers

    def initialize _response, _time = nil
      @limit = _response['x-rate-limit'].try(:to_i) || _response['x-ratelimit-limit-minute'].try(:to_i) || _response['X-Ratelimit-Total'].try(:to_i)
      @remaining = _response['x-rate-limit-remaining'].try(:to_i) || _response['x-ratelimit-remaining-minute'].try(:to_i) || _response['X-Ratelimit-Remaining'].try(:to_i)
      @code = _response.code.to_i
      if _response['content-type'].try { |ct| ct.include?("application/json") } == true
        begin
          @json = JSON.parse(_response.body)
        rescue
          @json = nil
        end
      else
        @json = nil
      end
      @body = _response.body
      @either = @json || @body
      @time = (Time.now - _time).to_f if _time
      @headers = {}
      _response.each do |key,val|
        @headers[key] = val
      end
    end

  end

end
