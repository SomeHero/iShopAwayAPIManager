#
# Be sure to run `pod lib lint IShopAwayApiManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IShopAwayApiManager'
  s.version          = '0.1.0'
  s.summary          = 'Shared API for iShopAway.'
  s.description      = 'Shared API for iShopAway'
  s.homepage         = 'https://github.com/somehero/IShopAwayApiManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'James Rhodes' => 'james@ishopaway.com' }
  s.source           = { :git => 'https://github.com/somehero/IShopAwayApiManager.git' }
  s.social_media_url = 'https://twitter.com/ishopaway'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IShopAwayApiManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'IShopAwayApiManager' => ['IShopAwayApiManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
