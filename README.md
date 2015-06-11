# IOBSimpleKeychain
===================
IOBSimpleKeychain makes it easier to use the iOS keychain how many of us do: as a generic bag to hold data in a secure manner with all the bells and whistles that iOS gives us with their SecureEnclave and other associated technologies.  Seriously, go read their [security white paper](https://www.apple.com/business/docs/iOS_Security_Guide.pdf).

To use, simply
```
IOBSimpleKeychain *simpleKeychain  = [[IOBSimpleKeychain alloc] initWithServiceName:@"com.indexoutofbounds.simplekeychain" sharedKeychainAccessGroup:@"ABCDEF69.com.indexoutofbounds.shared"];

[simpleKeychain putData:[@"foo" dataUsingEncoding:NSASCIIStringEncoding] atKey:@"foo"];
NSData * foo = [simpleKeychain dataForKey:@"foo"];
```

For sharing keychain items between apps there is a little bit more work you will need to do.  First off, the apps will need to be signed using the same provisioning profile.  Secondly, in each app you'll need to define in Xcode a capability for shared keychain access and also define a shared keychain access group.  Thirdly, you'll need the bundleSeedId which is an Apple generated thing it prepends to your shared keychain access group.  You can get this from the provisioning portal webapp or by following this post from [stack](http://stackoverflow.com/questions/11726672/access-app-identifier-prefix-programmatically/11841898#11841898)

** This is not ready for prime time just yet.  I need to test this on some devices.  **

Disclaimer: This *might* support OSX but it was developed for iOS use.  I have no interest in OSX development so I did not test it.

This project was created because security is a hard problem to solve and C apis don't help much.  I wanted a keychain services framework that encapsulated the SecItem apis into understandable objects and couldn't find that.

Pull requests are welcome.

Roadmap:
1. ability to add pkcs12 identities, certificates, keys as objects into the keychain system. (You can certainly do this with the NSData api.)
2. touch id
