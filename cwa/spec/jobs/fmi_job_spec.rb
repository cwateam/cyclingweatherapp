# coding: utf-8
require 'rails_helper'

RSpec.describe FmiJob, type: :job do

  it 'should work' do
  canned_answer = [[67.6521, 24.90162, 1433955600000, 10.9, "fmi"],
           [68.16972, 25.78306, 1433955000000, 8.6, "fmi"],
           [67.82151, 27.74635, 1433955000000, 9.5, "fmi"],
           [68.08422, 27.18501, 1433955000000, 8.5, "fmi"],
           [68.41506, 27.41326, 1433955000000, 10.3, "fmi"],
           [68.43394, 27.4441, 1433955000000, 8.9, "fmi"],
           [68.478, 28.30123, 1433955000000, 10.9, "fmi"],
           [67.74858, 29.61132, 1433955000000, 9.2, "fmi"],
           [69.04947, 20.79117, 1433955000000, 4.2, "fmi"],
           [69.04274, 20.85133, 1433955000000, -0.5, "fmi"],
           [68.60303, 23.57599, 1433955000000, 7.5, "fmi"],
           [68.90296, 25.73646, 1433955000000, 10.5, "fmi"],
           [68.6079, 27.41387, 1433955000000, 12.3, "fmi"],
           [69.75637, 27.00678, 1433955000000, 9.5, "fmi"],
           [69.07219, 27.4925, 1433955000000, 10.5, "fmi"],
           [69.14089, 27.26567, 1433955000000, 10.1, "fmi"],
           [68.84919, 28.2991, 1433955000000, 10.7, "fmi"]]

  t = 1433928013855
  
  Time.stub(:now) { Time.at(t/1000.to_f) }
  
  allow(FmiDatum).to receive(:deliver).and_return(canned_answer)

  fmi = FmiJob.new

  fmi.perform
  
  canned_answer.each { |r|
    body = <<MARKER
{"created":#{t},"datatype":"temperature","g":"#{GeoHash.encode(r[0], r[1])}","l":{"0":#{r[0]},"1":#{r[1]}},"mtime":#{r[2]},"value":#{r[3]},"source":"#{r[4]}"}
MARKER

    expect(WebMock).to have_requested(:post, "https://glowing-inferno-7580.firebaseio.com/fmi_temp.json").
            with(:body => JSON.parse(body), :headers => {'content_type'=>'application/json'})
  }
  end
end
