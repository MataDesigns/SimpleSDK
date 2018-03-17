#
# Be sure to run `pod lib lint EasyJSON.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SimpleSDK'
    s.version          = '1.1.0'
    s.summary          = 'Designed to help develop an SDK that is built around an API.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
    s.description      = <<-DESC
  A simple way to develop an SDK that is built around an API. Through the use of protocols and subclasses.
                         DESC
  
    s.homepage         = 'https://github.com/MataDesigns/SimpleSDK'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Nicholas Mata' => 'NicholasMata94@gmail.com' }
    s.source           = { :git => 'https://github.com/MataDesigns/SimpleSDK.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '9.0'
  
    s.source_files = 'SimpleSDK/**/*'
  
    s.frameworks =  'Foundation'

    s.dependency 'Alamofire' 
    s.dependency 'EasyJSON'
  end