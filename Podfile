platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

    # Pods for DietTestApp
def common_pods
        
    ## UI
    
    pod 'SnapKit'
    pod 'IQKeyboardManagerSwift'
    
    ## Reactive
    
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxBiBinding'
    pod 'RxDataSources'
    
    ## Database
    
    pod 'Unrealm'
    
    ## Swift Extension
  
    # SwifterSwift is a collection of over 500 native Swift extensions.
    # https://github.com/SwifterSwift/SwifterSwift
    pod 'SwifterSwift'

end

target 'DietTestApp' do
    common_pods
end


post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end
