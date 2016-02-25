Pod::Spec.new do |spec|
  spec.name             = 'D3Model'
  spec.version          = '2.0.3'
  spec.license          = { :type => "MIT", :file => 'LICENSE' }
  spec.homepage         = 'https://github.com/mozhenhau/D3Json'
  spec.authors          = {"mozhenhau" => "493842062@qq.com"}
  spec.summary          = 'ARC and GCD Compatible D3Json Class for iOS and OS X.'
  spec.source           =  {:git => 'https://github.com/mozhenhau/D3Json.git', :tag => '2.0.3' }
  spec.source_files     = 'D3Model/D3Model.swift'
  spec.requires_arc     = true
  spec.ios.deployment_target = '8.0'
end