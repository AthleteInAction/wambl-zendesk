require 'wambl_zendesk'

describe WamblZendesk::Requester do

  require 'setup'

  context "Create a ticket" do
    it "should respond with success (201) and ticket JSON" do
      ticket = {
        subject: "Assigned to will with no group",
        description: "Should be assigned to will and test group 1",
        assignee_id: 366362888934,
        requester_id: 114828884714
      }
      request = WamblZendesk::Requester.post("/api/v2/imports/tickets", ticket: ticket)
      expect(request.code).to eq(201)
      expect(request.json['ticket']).to be_present
      expect(request.json['ticket']['assignee_id']).to eq(366362888934)
      expect(request.json['ticket']['group_id']).to eq(114094882073)
    end
  end

end
