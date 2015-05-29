require 'rspec/rails'

describe 'FmiDatum' do

  it 'should parse and return a temperature record returned through HTTP GET' do

    canned_answer = File.new("./spec/lib/samples/fmi_temp_data.xml").read

    #might have to specify :get regex further
    stub_request(:get, /.*temperature.*/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    data = FmiDatum.deliver("temperature")
    
    expect(data.size).to eq(189)
    # check first station's record
    record = data[0]
    #expect(record[0]).to eq("100683")
    expect(record[0]).to eq("60.30375")
    expect(record[1]).to eq("25.54925")
    expect(record[2]).to eq(1432409400)
    expect(record[3]).to eq(7.6)
    expect(record[4]).to eq("fmi")
    #expect(record[5]).to eq("Porvoo Kilpilahti satama")

    # check last station's record
    record = data[188]
    #expect(record[0]).to eq("874863")
    expect(record[0]).to eq("60.17802")
    expect(record[1]).to eq("24.78732")
    expect(record[2]).to eq(1432409400)
    expect(record[3]).to eq(8.1)
    expect(record[4]).to eq("fmi")
    #expect(record[5]).to eq("Espoo Tapiola")

  end
end
