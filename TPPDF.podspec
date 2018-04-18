Pod::Spec.new do |s|
  s.name             = 'TPPDF'
  s.version          = '1.0.2'
  s.summary          = 'TPPDF is a simple-to-use PDF builder for iOS'
  s.description      = <<-DESC
    TPPDF is an object-based PDF builder.
    You create a document by defining, adding and positioning different objects.
    TPPDF then calculates the document and creates a PDF.
                       DESC

  s.homepage         = 'https://github.com/techprimate/TPPDF'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Philip Niedertscheider' => 'phil@techprimate.com' }
  s.source           = { :git => 'https://github.com/Techprimate/TPPDF.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/techprimate'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'

  s.dependency 'SwiftLint'

end
