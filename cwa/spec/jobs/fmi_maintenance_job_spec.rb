require 'rails_helper'

RSpec.describe FmiMaintenanceJob, type: :job do
  
  after do
    WebMock.reset!
  end

  it 'should work' do

  uri = 'https://glowing-inferno-7580.firebaseio.com/data.json?endAt=1433924413855&orderBy=%22mtime%22'


  canned_answer = File.new("./spec/lib/samples/fmi_temp_data_from_firebase.json").read

  t = 1433928013855
  
  Time.stub(:now) { Time.at(t/1000.to_f) }
  
  stub_request(:get, uri).
    to_return(:body => canned_answer, headers: { 'Content-Type' => "text/json" })
  
  fmi = FmiMaintenanceJob.new
  
  fmi.perform

  data_to_be_deleted = JSON.parse(canned_answer)
  
  data_to_be_deleted.each { |key, value|
    expect(WebMock).to have_requested(:delete, "https://glowing-inferno-7580.firebaseio.com/data/#{key}.json")  
  }
  
  end
end
