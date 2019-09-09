require 'active_support/all'
require "wambl_zendesk/version"
require "wambl_zendesk/configuration"
require "wambl_zendesk/requester"
require "wambl_zendesk/loops"
require "wambl_zendesk/resource"
require "wambl_zendesk/group"
require "wambl_zendesk/organization"
require "wambl_zendesk/user"
require "wambl_zendesk/ticket"
require "wambl_zendesk/ticket_comment"
require "wambl_zendesk/ticket_field"
require "wambl_zendesk/attachment"
require "wambl_zendesk/import"

module WamblZendesk
  class Instance
    include WamblZendesk::Requester
    include WamblZendesk::Loops
    alias :post :get
    alias :put :get
    alias :patch :get
    alias :delete :get
    def initialize
      @config ||= WamblZendesk::Configuration.new
      yield(@config) if block_given?
      @config
    end
    def config
      @config || self.configure
    end
  end
end
