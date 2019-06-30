# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UITestDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'IBAnimatable', '5.2.1'
  pod 'SnapKit', '4.2.0'
  pod 'EZSwiftExtensions', '2.0'
  # Pods for UITestDemo
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['SnapKit'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
    if ['IBAnimatable', 'EZSwiftExtensions'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
  end

end
