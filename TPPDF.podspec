Pod::Spec.new do |s|
  s.name             = 'TPPDF'
  s.version          = '1.0.0'
  s.summary          = 'TPPDF is a simple-to-use PDF builder for iOS'
  s.description      = <<-DESC
TPPDF is a PDF builder based on the 'Builder' pattern. It uses the built-in framework for generating PDF files.
                       DESC

  s.homepage         = 'https://github.com/techprimate/TPPDF'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Philip Niedertscheider' => 'phil@techprimate.com' }
  s.source           = { :git => 'https://github.com/Techprimate/TPPDF.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/techprimate'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'
  s.frameworks = 'UIKit'
end
