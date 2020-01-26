#
# Be sure to run `pod lib lint SwiftyDeck.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyDeck'
  s.version          = '0.1.4'
  s.summary          = 'A Swifty Framework for Card Games'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SwiftyDeck is created in order to reuse mostly-generic Card/Deck concept for any project.
                       DESC

  s.homepage         = 'https://github.com/edusta/SwiftyDeck'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Engin Deniz Usta' => 'engin@ceng.metu.edu.tr' }
  s.source           = { :git => 'https://github.com/edusta/SwiftyDeck.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/edustaa'

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.source_files = 'SwiftyDeck/Classes/**/*'
  
  s.resources = 'SwiftyDeck/Assets/**'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
