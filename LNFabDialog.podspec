#
# Be sure to run `pod lib lint LNFabDialog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LNFabDialog'
  s.version          = '1.0.0'
  s.summary          = 'Simple dialog alert from Material Float Action Button'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

Simple dialog following Google Material Design specs.

                       DESC

  s.homepage         = 'https://github.com/lucasanovaes/LNFabDialog'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Novaes' => 'lanovaes1@gmail.com' }
  s.source           = { :git => 'https://github.com/lucasanovaes/LNFabDialog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'LNFabDialog/Classes/**/*', 
  s.frameworks = 'UIKit', 'Foundation'

  # s.resource_bundles = {
  #   'LNFabDialog' => ['LNFabDialog/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
