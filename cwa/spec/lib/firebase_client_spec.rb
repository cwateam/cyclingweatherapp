require 'rspec/rails'

describe 'FirebaseClient' do
  
  it 'should send correct post request' do
    
    f = FirebaseClient.new
    
    f.post("test", :test_data => "test string")
    
    body = <<MARKER
{"test_data":"test string"}
MARKER
    
    expect(WebMock).to have_requested(:post, "https://glowing-inferno-7580.firebaseio.com/test.json").
                        with(:body => JSON.parse(body), :headers => {'content_type'=>'application/json'})
    
  end
end
