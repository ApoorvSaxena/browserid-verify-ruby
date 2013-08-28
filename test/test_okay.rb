require "json"

require "test/unit"
require 'webmock/test_unit'
require 'browserid/verify'

include WebMock::API
include BrowserID::Verify

response = {
    "status"   => "okay",
    "email"    => "me@example.com",
    "audience" => "https://example.com",
    "expires"  => 1354217396705,
    "issuer"   => "example.com"
}
response = JSON.generate(response)

stub_request(:post, "https://verifier.login.persona.org/verify").
  with(:body => {"assertion"=>"a fake assertion", "audience"=>"http://localhost"},
       :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => response, :headers => {'Content-Type'=>'application/json'})

class TC_Verify < Test::Unit::TestCase
  def test_okay
    data = verify_remotely('http://localhost', 'a fake assertion')
    assert_equal('okay', data['status'])
    assert_equal('me@example.com', data['email'])

    assert_equal(data['status'], 'okay', 'Response status is okay.');
    assert_equal(data['email'], 'me@example.com', 'Email in response is same as email passed back.');
    assert_equal(data['issuer'], 'example.com', 'Issuer is also example.com.');
    assert_equal(data['expires'], 1354217396705, 'Expires is correct.');
    assert_equal(data['audience'], 'https://example.com', 'Audience is correct.');

    assert_equal(data['reason'], nil, 'No reason in the response at all.');
  end
end
