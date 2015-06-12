require 'rspec/rails'

describe 'FmiDatum' do

  it 'should parse and return a temperature record returned through HTTP GET' do

    canned_answer = File.new("./spec/lib/samples/fmi_temp_data.xml").read

    #might have to specify :get regex further
    stub_request(:get, /.*temperature.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    t = 1433928013855
  
    Time.stub(:now) { Time.at(t/1000.to_f) }
    
    data = FmiDatum.deliver("temperature")
    
    expect(data.size).to eq(189)
    # check first station's record
    record = data[0]
    expect(record["created"]).to eq(t)
    expect(record["l"]['0']).to eq(60.30375)
    expect(record["l"]['1']).to eq(25.54925)
    expect(record["mtime"]).to eq(1432409400000)
    expect(record["value"]).to eq(7.6)
    expect(record["source"]).to eq("fmi")

    # check last station's record
    record = data[188]
    expect(record["created"]).to eq(t)
    expect(record["l"]['0']).to eq(60.17802)
    expect(record["l"]['1']).to eq(24.78732)
    expect(record["mtime"]).to eq(1432409400000)
    expect(record["value"]).to eq(8.1)
    expect(record["source"]).to eq("fmi")

  end
end
