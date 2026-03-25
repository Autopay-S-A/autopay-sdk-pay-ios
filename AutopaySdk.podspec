Pod::Spec.new do |s|
  s.name     = 'Autopay'
  s.version  = '4.0.2'
  s.summary  = 'Autopay SDK'
  s.homepage = 'https://github.com/Autopay-S-A/autopay-sdk-pay-ios'
  s.author   = { 'Autopay' => 'support@autopay.pl' }
  s.source   = { :git => 'git@github.com:Autopay-S-A/autopay-sdk-pay-ios.git', :tag => s.version }

  s.ios.deployment_target = '15.0'
  s.default_subspecs = 'Core'   # domyślnie wariant z OCR

  s.subspec 'Core' do |ss|
    ss.vendored_frameworks = 'Artifacts/AutopaySdk.xcframework'
    ss.frameworks = 'PassKit', 'Combine', 'Vision', 'VisionKit', 'UIKit', 'SwiftUI', 'WebKit'
  end

  s.subspec 'WithoutOCR' do |ss|
    ss.vendored_frameworks = 'Artifacts/AutopaySdkWithoutOCR.xcframework'
    ss.frameworks = 'PassKit', 'Combine', 'UIKit', 'SwiftUI', 'WebKit'
  end
end
