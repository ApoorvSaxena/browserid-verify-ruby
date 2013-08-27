require "test/unit"
require 'webmock/test_unit'
require 'browserid/verify'

include WebMock::API
include BrowserID::Verify

stub_request(:post, "https://verifier.login.persona.org/verify").
  with(:body => {"assertion"=>"invalid assertion", "audience"=>"http://localhost"},
       :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
  to_return(:status => 503, :body => "Server is busy, try again later.", :headers => {})

class TC_Verify < Test::Unit::TestCase
  def test_busy
    data = verify_remotely('http://localhost', 'invalid assertion')
    assert_equal('failure', data['status'])
    assert_equal('Something went wrong with the request', data['reason'])
    assert_equal('Server is busy, try again later.', data['body'])
  end
end
