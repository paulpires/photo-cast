# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'photo-cast' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Firebase/Analytics'

  target 'photo-castTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'photo-castUITests' do
    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
  end
end