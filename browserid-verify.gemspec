#!/usr/bin/env gem build

Gem::Specification.new do |s|
  s.name             = 'browserid-verify'
  s.version          = '0.1.0'
  s.summary          = "A BrowserID Verifier."
  s.description      = "Verify BrowserID assertions either remotely or locally (only remote implemented currently)."
  s.homepage         = 'https://github.com/chilts/browserid-verify-ruby'
  s.license          = 'MPL 2'

  s.date             = '2013-08-21'
  s.author           = "Andrew Chilton"
  s.email            = 'chilts@mozilla.com'

  s.require_paths    = ["lib"]
  s.files            = ["LICENSE", "README.md", "lib/browserid/verify.rb"]

  s.extra_rdoc_files = ["LICENSE", "README.md"]

  s.test_files = ["test/test_busy.rb", "test/test_okay.rb", "test/integration/test_failure.rb"]
end
