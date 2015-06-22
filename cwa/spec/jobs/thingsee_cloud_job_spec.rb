require 'rails_helper'

RSpec.describe ThingseeCloudJob, type: :job do

  after do
    WebMock.reset!
  end
  
  it 'should work' do
  canned_answer = [67.6521, 24.90162, 1433955600000, 10.9, "thingsee"]

  t = 1433928013855
  
  Time.stub(:now) { Time.at(t/1000.to_f) }
  
  allow(ThingseeCloudDatum).to receive(:deliver).and_return(canned_answer)
  
  ts = ThingseeCloudJob.new
  
  ts.perform
  
  body = <<MARKER
{"created":#{t},"datatype":"temperature","g":"#{GeoHash.encode(canned_answer[0], canned_answer[1])}","l":{"0":#{canned_answer[0]},"1":#{canned_answer[1]}},"mtime":#{canned_answer[2]},"value":#{canned_answer[3]},"source":"#{canned_answer[4]}"}
MARKER
  
  expect(WebMock).to have_requested(:post, "https://glowing-inferno-7580.firebaseio.com/data.json").
                      with(:body => JSON.parse(body), :headers => {'content_type'=>'application/json'})
  end
end
