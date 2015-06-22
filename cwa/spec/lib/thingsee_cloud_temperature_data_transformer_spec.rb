require 'rspec/rails'

describe 'ThingseeCloudTemperatureDataTransformer' do

  after do
    WebMock.reset!
  end
  
  it 'should work' do
    
    #fmi_temp_data = File.new("./spec/lib/samples/fmi_temp_data.xml").read

    #xml_doc = Nokogiri::XML::Document.parse(fmi_temp_data)

    canned_answer = File.new("./spec/lib/samples/thingsee_temp_data_from_thingsee_cloud.json").read

    t = 1433928013855
    
    Time.stub(:now) { Time.at(t/1000.to_f) }

    uri = 'https://test.com'
    
    stub_request(:get, uri).
      to_return(:body => canned_answer, headers: { 'Content-Type' => "text/json" })
    

    result = HTTParty.get(uri)
    
    data = ThingseeCloudTemperatureDataTransformer.transform(result)
    
    expect(data.size).to eq(1)
    
    record = data[0]
    expect(record.size).to eq(7)
    expect(record["created"]).to eq(t)
    expect(record["l"]['0']).to eq(60.204372406)
    expect(record["l"]['1']).to eq(24.962223053)
    expect(record["g"]).to eq("ud9y2pbgvu")
    expect(record["mtime"]).to eq(1434956154867)
    expect(record["value"]).to eq(19.87)
    expect(record["source"]).to eq("thingsee")
    expect(record["sensor_type"]).to eq("temperature")
  end
end
