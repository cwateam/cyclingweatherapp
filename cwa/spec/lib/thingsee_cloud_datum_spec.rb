require 'rspec/rails'

describe 'ThingseeCloudDatum' do

  it 'should return error with incomplete input' do
    canned_answer = File.new("./spec/lib/samples/thingsee_single_temp.json").read

    #might have to specify :get regex further?
    stub_request(:get, /.*0x00060100.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "application/json" })

    record = ThingseeCloudDatum.deliver("temperature")
    expect(record).to eq("error")
  end

  it 'should parse and return a temperature with location record from a well-formed response returned through get' do
    canned_answer = File.new("./spec/lib/samples/thingsee_temp_with_loc.json").read

    #might have to specify :get regex further?
    stub_request(:get, /.*0x00060100.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "application/json" })

    record = ThingseeCloudDatum.deliver("temperature")
    # check first station's record
    expect(record[0]).to eq(60.1820)
    expect(record[1]).to eq(24.9255)
    expect(record[2]).to eq(1432852761910)
    expect(record[3]).to eq(26.94)
    expect(record[4]).to eq("thingsee")

  end

  it 'should parse and return a temperature with location record from a complex response returned through get' do
    #TODO; wrong stub file
    # the idea for this is that ThingseeDatum should be able to parse a temperature record from input
    # with various events with different timestamps; i.e. the file specified below in the commented out version
    #canned_answer = File.new("./spec/lib/samples/thingsee_multiple_events.json").read
    canned_answer = File.new("./spec/lib/samples/thingsee_temp_with_loc.json").read

    #might have to specify :get regex further?
    stub_request(:get, /.*0x00060100.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "application/json" })

    record = ThingseeCloudDatum.deliver("temperature")
    # check first station's record
    expect(record[0]).to eq(60.1820)
    expect(record[1]).to eq(24.9255)
    expect(record[2]).to eq(1432852761910)
    expect(record[3]).to eq(26.94)
    expect(record[4]).to eq("thingsee")

  end
end
