require 'rspec/rails'

describe 'FmiData' do

  it 'should parse and return a temperature record returned through HTTP GET' do

    apikey = ENV["FMI_APIKEY"]
    canned_answer = File.new("./spec/lib/fmi_example.xml").read

    #might have to specify :get regex further
    stub_request(:get, /.*temperature.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    data = FmiData.deliver("temperature")
    expect(data.size).to eq(189)
    # check first station's record
    record = data[0]
    expect(record[0]).to eq("100683")
    expect(record[1]).to eq("60.30375")
    expect(record[2]).to eq("25.54925")
    expect(record[3]).to eq("2015-05-23T19:30:00Z")
    expect(record[4]).to eq("7.6")
    expect(record[5]).to eq("Porvoo Kilpilahti satama")

    # check last station's record
    record = data[188]
    expect(record[0]).to eq("874863")
    expect(record[1]).to eq("60.17802")
    expect(record[2]).to eq("24.78732")
    expect(record[3]).to eq("2015-05-23T19:30:00Z")
    expect(record[4]).to eq("8.1")
    expect(record[5]).to eq("Espoo Tapiola")

  end
end