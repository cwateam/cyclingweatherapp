require 'rspec/rails'

describe 'FmiTemperatureDataTransformer' do

  after do
    WebMock.reset!
  end
  
  it 'should work' do
    
    fmi_temp_data = File.new("./spec/lib/samples/fmi_temp_data.xml").read

    xml_doc = Nokogiri::XML::Document.parse(fmi_temp_data)

    t = 1433928013855
    
    Time.stub(:now) { Time.at(t/1000.to_f) }
    
    data = FmiTemperatureDataTransformer.transform(xml_doc)
    
    expect(data.size).to eq(189)
    # check first station's record
    record = data[0]
    expect(record.size).to eq(7)
    expect(record["created"]).to eq(t)
    expect(record["l"]['0']).to eq(60.30375)
    expect(record["l"]['1']).to eq(25.54925)
    expect(record["g"]).to eq("uddpj3uqu9")
    expect(record["mtime"]).to eq(1432409400000)
    expect(record["value"]).to eq(7.6)
    expect(record["source"]).to eq("fmi")
    expect(record["sensor_type"]).to eq("temperature")

    # check last station's record
    record = data[188]
    puts record
    expect(record.size).to eq(7)
    expect(record["created"]).to eq(t)
    expect(record["l"]['0']).to eq(60.17802)
    expect(record["l"]['1']).to eq(24.78732)
    expect(record["g"]).to eq("ud9wk51d67")
    expect(record["mtime"]).to eq(1432409400000)
    expect(record["value"]).to eq(8.1)
    expect(record["source"]).to eq("fmi")
    expect(record["sensor_type"]).to eq("temperature")
  end
end
