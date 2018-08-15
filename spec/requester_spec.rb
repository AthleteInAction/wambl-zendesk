require 'wambl_zendesk'

describe WamblZendesk::Requester do

  require 'setup'

  context "Request the surrent user" do
    it "should respond with success (201) and user JSON" do
      request = WamblZendesk::Requester.get("/api/v2/users/me")
      expect(request.code).to eq(200)
      expect(request.json['user']).to be_present
    end
  end

end
