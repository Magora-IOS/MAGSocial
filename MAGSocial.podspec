#
# Be sure to run `pod lib lint MAGSocial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MAGSocial'
  s.version          = '0.0.5'
  s.summary          = 'MAGSocial is a unified API for common and specific social network features'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MAGSocial provides unified API for common and specific social network features.
Supported social networks and their features: TODO
                       DESC

  s.homepage         = 'https://github.com/Magora-IOS/MAGSocial'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'zlib', :file => 'LICENSE' }
  s.author           = { 'Michael Kapelko' => 'kornerr@gmail.com' }
  s.source           = { :git => 'https://github.com/Magora-IOS/MAGSocial.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MAGSocial/Classes/**/*'
  s.preserve_path =  'MAGSocial/ConfigureMainPlist.sh'
  s.user_target_xcconfig = { 'MAGSocialPlistSettingsFileName' => 'MAGSocial-Settings.plist' }


end
