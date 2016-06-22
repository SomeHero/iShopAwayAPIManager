#
# Be sure to run `pod lib lint IShopAwayApiManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IShopAwayApiManager'
  s.version          = '0.1.14'
  s.summary          = 'Shared API for iShopAway.'
  s.description      = 'Shared API for iShopAway'
  s.homepage         = 'https://github.com/iShopAway/ishopaway-apimanager-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'James Rhodes' => 'james@ishopaway.com' }
  s.source           = { :git => 'https://github.com/iShopAway/ishopaway-apimanager-ios' }
  s.social_media_url = 'https://twitter.com/ishopawayapp'

  s.ios.deployment_target = '8.0'


  ## Specs
  s.subspec "Root" do |sub|
    sub.source_files  ='IShopAwayApiManager/Classes/**/*'
    sub.framework     = "Foundation"

    sub.dependency 'Alamofire',      '~> 3.4.0'
    sub.dependency 'ObjectMapper',   '~> 1.3.0'
    sub.dependency 'SwiftyJSON',    '~> 2.3.2'
    sub.dependency 'AlamofireObjectMapper', '~> 3.0.0'
  end
end
