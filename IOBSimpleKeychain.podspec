Pod::Spec.new do |s|

  s.name         = "IOBSimpleKeychain"
  s.version      = "1"
  s.summary      = "IOBSimpleKeychain - the simple and clean way to use the iOS Keychain"

  s.description  = <<-DESC
Lightweight iOS framework for adding generic data to the iOS Keychain using the Keychain Services API. Goals are simplicity both in external API and internal implementation.
                   DESC

  s.homepage     = "http://github.com/tmeisenh/IOBSimpleKeychain"

  s.license      = 'FreeBSD License'
  s.author       = "Travis B. Meisenheimer"

  s.platform     = :ios, "7.1"

  s.source       = { :git => "https://github.com/tmeisenh/IOBSimpleKeychain.git", :tag => s.version }

  s.requires_arc = true
  s.frameworks = "Foundation", "UIKit"

  s.source_files  = "IOBSimpleKeychain/**/*.{h,m}"

  s.header_dir = "IOBSimpleKeychain"
  s.public_header_files = "IOBSimpleKeychain/IOBSimpleKeychain.h"

end
