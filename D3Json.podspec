Pod::Spec.new do |spec|
  spec.name             = 'D3Json'
  spec.version          = '1.0.0'
  spec.license          = 'MIT'
  spec.homepage         = 'https://mozhenhau@github.com/mozhenhau/D3Json.git'
  spec.authors          = {"mozhenhau" => "493842062@qq.com"}
  spec.summary          = 'ARC and GCD Compatible D3Json Class for iOS and OS X.'
  spec.source           =  {:git => 'https://mozhenhau@github.com/mozhenhau/D3Json.git', :tag => '1.0.0' }
  spec.source_files     = 'D3JsonTests/D3json/*.swift'
  spec.requires_arc     = true
end