platform :ios, '8.0'
workspace 'HireMe'
use_frameworks!

def common_client_pods
  project 'HireMeClient/HireMeClient.xcodeproj'
#   pod 'Alamofire', '4.5.1'
  pod 'GoogleMaps', '2.4.0'
  pod 'GooglePlaces', '2.4.0'
  pod 'SwiftyBeaver', '1.4.0'
  pod 'PureLayout', '3.0.2'
  pod 'SwiftyJSON', '3.1.4'
end

target 'HireMeiPhone' do
  common_client_pods 
  pod 'SlideMenuControllerSwift', '3.0.2'
end

target 'HireMeiPad' do
  common_client_pods 
end

target 'Utility' do
  project 'Utility/Utility.xcodeproj'
  pod 'SwiftyBeaver', '1.4.0'
end