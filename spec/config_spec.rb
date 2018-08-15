require 'wambl_zendesk'

describe WamblZendesk::Configuration do

  require 'setup'
  
  it "should set subdomain and api key" do
    expect(WamblZendesk.config.subdomain).to_not be_nil
    expect(WamblZendesk.config.api_key).to_not be_nil
  end

end
