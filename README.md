# browserid-verify #

Verify BrowserID assertions in Ruby.

Currently this package only allows remote verification. Once the assertion format has stabilised we'll also add the
ability to verify assertions locally.

## Installation ##

Install as Ruby Gem in your Project.

```
gem install browserid-verify
```

## Usage ##

```
require 'browserid/verify'
include BrowserID::Verify
```

Using the functional API, you can call ```verify_remotely()``` with both an ```audience``` and an ```assertion```.

```
data = verify_remotely(audience, assertion)
puts "Data: #{data.inspect}"
```

Using the class API, you can create an instance which will keep the ```audience``` for you, assuming it doesn't
change in the code you're using it in. Pass it a ```type``` (which is 'remote' or 'local' - only 'remote' is currently
supported) and the audience.

Then, use the ```verify()``` method to give it the assertion.

```
verifier = Verify.new('remote', audience)

data = verifier.verify(assertion)
puts "Data: #{data.inspect}"
```

Using your own hosted version of the verifier, you can pass in a URL as the third parameter of either the constructor
or the ```verify_remotely()``` function.

```
data = verify_remotely(audience, assertion, 'https://verifier.localhost/')

# or

verifier = Verify.new('remote', audience, 'https://verifier.localhost/')
data = verifier.verify(assertion)
```

## API ##

Functional interface:

```data = verify_remotely(audience, assertion[, url = 'https://verifier.login.persona.org/verify'])```

Object interface:

```verifier = Verify.new(type, audience[, url = 'https://verifier.login.persona.org/verify'])```

```data = verifier.verify(assertion)```

Options:

```type``` - must be 'remote' or 'local' (this library currently only supports 'remote'

```audience``` - should be your hostname such as ```https://example.com```

```assertion``` - the long opaque string given to your server by the browser

```url``` - the url of your locally hosted verifier, defaults to ```https://verifier.login.persona.org/verify```

## Remote v Local Verification ##

Currently BrowserID is in Beta and therefore the assertion format is subject to change. Therefore we use the hosted
service at https://verifier.login.persona.org/verify to do the verification for us. This means you won't need to change
your code if the assertion format changes.

However, once BrowserID is out of Beta and the assertion format is stable, we will switch this library to use local
verification. Once this is done it achieves one of BrowserIDs goals which is that of distributed verification with no
central service needed.

Therefore, this library currently only implements remote verification.

However, the library will also perform local verification at some point in the future and will provide an easy upgrade
path to make sure it is easy to switch from one to the other.

Both remote and local verification functions will have the same API to allow this to happen.

## License ##

MPL 2.0

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

(Ends)
