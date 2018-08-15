require 'wambl_zendesk'

describe WamblZendesk::Group do

  require 'setup'
  require 'awesome_print'

  context "Get a single group by id" do
    it "should return a group JSON object" do
      group_id = 360001783292
      group = WamblZendesk::Group.find(group_id)
      expect(group.id).to eq(group_id)
    end
  end

  context "Get a page of groups" do
    it "should return an array of groups" do
      WamblZendesk::Group.page(1) do |group|
      end
      expect(true).to be true
    end
  end

end
