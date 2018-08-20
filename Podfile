# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'iOS-Base' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOS-Base
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SideMenu'
  pod 'NVActivityIndicatorView', '~> 3.6.0'
  pod 'Alamofire', '~> 4.4'
  pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher', :branch => 'master'

  target 'iOS-BaseTests' do
    inherit! :search_paths
    # Pods for testing
        pod 'Quick', '1.1.0'
        pod 'Nimble', '7.0.1'
  end

  target 'iOS-BaseUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
