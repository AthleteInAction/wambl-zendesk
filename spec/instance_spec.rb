require 'wambl_zendesk'

describe WamblZendesk::Instance do

  require 'awesome_print'

  context "Initial testing" do
    it "should not raise exception" do
      ZENDESK = WamblZendesk::Instance.new do |config|
        config.subdomain = ""
        config.email = ""
        config.token = ""
      end
      request = ZENDESK.get("/api/v2/users/me")
      expect(request.code).to eq(200)
    end
  end

end
