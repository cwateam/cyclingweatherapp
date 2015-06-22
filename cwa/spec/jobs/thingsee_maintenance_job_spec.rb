require 'rails_helper'

RSpec.describe ThingseeMaintenanceJob, type: :job do

  after do
    WebMock.reset!
  end
  
  it 'should work' do
  
  uri = 'https://glowing-inferno-7580.firebaseio.com/data.json?endAt=1433668813855&orderBy=%22mtime%22'

  canned_answer = File.new("./spec/lib/samples/ts_temp_data_from_firebase.json").read

  Time.stub(:now) { Time.at(1433928013855/1000.to_f) }
  
  stub_request(:get, uri).
    to_return(:body => canned_answer, headers: { 'Content-Type' => "text/json" })
  
  ts = ThingseeMaintenanceJob.new
  
  ts.perform

  data_to_be_deleted = JSON.parse(canned_answer)
  
  data_to_be_deleted.each { |key, value|
    expect(WebMock).to have_requested(:delete, "https://glowing-inferno-7580.firebaseio.com/data/#{key}.json")  
  }
  
  end
end
