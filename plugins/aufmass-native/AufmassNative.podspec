Pod::Spec.new do |s|
  s.name             = 'AufmassNative'
  s.version          = '1.0.0'
  s.summary          = 'AirPrint/PDF für die Aufmaß-App'
  s.license          = { :type => 'Proprietary', :text => 'Holzcenter Nilges / Schreinerei Link' }
  s.homepage         = 'https://holzcenter-nilges.de'
  s.author           = 'Holzcenter Nilges'
  s.source           = { :git => 'https://holzcenter-nilges.de/aufmass-native.git', :tag => s.version.to_s }
  s.source_files     = 'ios/Plugin/**/*.{swift,h,m}'
  s.ios.deployment_target = '14.0'
  s.dependency 'Capacitor'
  s.swift_version    = '5.1'
end
