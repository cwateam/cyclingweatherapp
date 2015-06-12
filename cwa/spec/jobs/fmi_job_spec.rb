# coding: utf-8
require 'rails_helper'

RSpec.describe FmiJob, type: :job do

  after do
    WebMock.reset!
  end
  
  it 'should work' do
  canned_answer = [{"created"=>1434106030037, "l"=>{"0"=>68.84919, "1"=>28.2991}, "g"=>"ushpevwg8g", "mtime"=>1434105600000, "value"=>10.3, "source"=>"fmi"}, {"created"=>1434106030037, "l"=>{"0"=>69.5825, "1"=>28.89409}, "g"=>"uskece053n", "mtime"=>1434105600000, "value"=>9.5, "source"=>"fmi"}, {"created"=>1434106030038, "l"=>{"0"=>64.21678, "1"=>27.75194}, "g"=>"ue7trd23g5", "mtime"=>1434105600000, "value"=>13.9, "source"=>"fmi"}, {"created"=>1434106030039, "l"=>{"0"=>69.757, "1"=>27.012}, "g"=>"us7hydvecp", "mtime"=>1434105600000, "value"=>11.0, "source"=>"fmi"}, {"created"=>1434106030040, "l"=>{"0"=>69.04832, "1"=>27.75682}, "g"=>"us78z9ggsg", "mtime"=>1434105600000, "value"=>8.1, "source"=>"fmi"}, {"created"=>1434106030040, "l"=>{"0"=>61.52242, "1"=>28.18491}, "g"=>"udujcrgdh4", "mtime"=>1434105600000, "value"=>11.8, "source"=>"fmi"}, {"created"=>1434106030041, "l"=>{"0"=>60.20867, "1"=>25.1959}, "g"=>"ud9yt2ehgj", "mtime"=>1434105960000, "value"=>14.1, "source"=>"fmi"}, {"created"=>1434106030042, "l"=>{"0"=>60.11592, "1"=>20.2976}, "g"=>"u6wmvzu287", "mtime"=>1434105960000, "value"=>19.8, "source"=>"fmi"}, {"created"=>1434106030043, "l"=>{"0"=>61.50123, "1"=>23.76468}, "g"=>"udbvugbyth", "mtime"=>1434105600000, "value"=>17.2, "source"=>"fmi"}, {"created"=>1434106030044, "l"=>{"0"=>67.99739, "1"=>24.20946}, "g"=>"us14yfsc92", "mtime"=>1434105600000, "value"=>8.9, "source"=>"fmi"}, {"created"=>1434106030044, "l"=>{"0"=>66.1715, "1"=>29.1364}, "g"=>"ueu8rn0kzm", "mtime"=>1434105600000, "value"=>10.2, "source"=>"fmi"}, {"created"=>1434106030045, "l"=>{"0"=>60.29128, "1"=>24.56788}, "g"=>"ud9qzp9y1j", "mtime"=>1434105600000, "value"=>21.3, "source"=>"fmi"}, {"created"=>1434106030046, "l"=>{"0"=>60.17802, "1"=>24.78732}, "g"=>"ud9wk51d67", "mtime"=>1434105600000, "value"=>17.8, "source"=>"fmi"}]

  t = 1433928013855
  
  Time.stub(:now) { Time.at(t/1000.to_f) }
  
  allow(FmiDatum).to receive(:deliver).and_return(canned_answer)

  fmi = FmiJob.new
  
  fmi.perform
  
  canned_answer.each { |r|
    expect(WebMock).to have_requested(:post, "https://glowing-inferno-7580.firebaseio.com/data.json").
                        with(:body => JSON.parse(r.to_json), :headers => {'content_type'=>'application/json'})
  }
  end
end
