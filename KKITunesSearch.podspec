Pod::Spec.new do |s|
  s.name         = "KKITunesSearch"
  s.version      = "0.0.1"
  s.summary      = "iTunes Search API Objective-C client."
  s.homepage     = "https://github.com/lakim/KKITunesSearch"
  s.license      = 'MIT'
  s.author       = { "Louis-Alban KIM" => "louis.alban.kim@gmail.com" }
  s.source       = { :git => "https://github.com/lakim/KKITunesSearch.git", :commit => "5e2c5e3b562ac587b5ddc83bfd992c157753a867" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.source_files = 'KKITunesSearch', 'KKITunesSearch/**/*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 1.0'
end
