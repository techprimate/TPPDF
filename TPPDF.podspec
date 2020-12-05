Pod::Spec.new do |s|
  s.name             = 'TPPDF'
  s.version          = '2.3.2'
  s.summary          = 'TPPDF is a simple-to-use PDF builder for iOS'
  s.description      = <<-DESC
    TPPDF is an object-based PDF builder, completely built in Swift.
    You create a document by defining, adding and positioning different objects.
    TPPDF then calculates the layout and renders a PDF file.
                       DESC

  s.homepage         = 'https://github.com/techprimate/TPPDF'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Philip Niedertscheider' => 'dev@philpri.me' }
  s.source           = { :git => 'https://github.com/techprimate/TPPDF.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/techprimate'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
  s.swift_version = '5.2'

end
