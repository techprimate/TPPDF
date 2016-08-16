Pod::Spec.new do |s|
  s.name             = 'TPPDF'
  s.version          = '0.1.0'
  s.summary          = 'TPPDF is a simple-to-use PDF builder for iOS'
  s.description      = <<-DESC
TPPDF is a simple-to-use PDF builder. It uses the built-in framework for generating PDF files. Included features are: text, attributed text, images, tables
                       DESC

  s.homepage         = 'https://github.com/techprimate/TPPDF'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Philip Niedertscheider' => 'philip.niedertscheider@techprimate.com' }
  s.source           = { :git => 'https://github.com/techprimate/TPPDF.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/techprimate'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TPPDF/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TPPDF' => ['TPPDF/Assets/*.png']
  # }

  s.frameworks = 'UIKit'
end
