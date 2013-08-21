require "test/unit"
require "browserid-verify"

class TC_Verify < Test::Unit::TestCase
  def test_simple_1
    v = Verify.new('remote', 'http://localhost')
    data = v.verify('invalid assertion')
    assert_equal(data['status'], 'failure')
    assert_equal(data['reason'], 'no certificates provided')
  end

  def test_simple_2
    data = verify_remotely('http://localhost', 'invalid assertion')
    assert_equal(data['status'], 'failure')
    assert_equal(data['reason'], 'no certificates provided')
  end
end
