module WamblZendesk

  # Configuration
  # ====================================================
  class Configuration
    attr_reader :uri
    attr_accessor :subdomain
    attr_accessor :rpm
    attr_accessor :api_path
    def subdomain=(value)
      @subdomain = value
      @uri = URI.parse("https://#{@subdomain}.zendesk.com")
    end
    attr_accessor :email
    attr_accessor :password
    attr_accessor :token
    def initialize
      self.rpm = 700
      self.api_path = "/api/v2"
    end
    def [](value)
      self.public_send(value)
    end
  end
  def self.configure
    @config ||= Configuration.new
    yield(@config) if block_given?
    @config
  end
  def self.config
    @config || self.configure
  end
  # ====================================================

end
