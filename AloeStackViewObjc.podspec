Pod::Spec.new do |s|
s.name = 'AloeStackViewObjc'
s.version = '0.0.1'
s.license      = { :type => 'MIT' :file => 'LICENSE' }
s.summary = 'nope'
s.homepage = 'https://github.com/fiveplusseven/AloeStackViewObjc'
s.authors = { "longjianjiang" => "brucejiang5.7@gmail.com" }
s.source = { :git => 'https://github.com/fiveplusseven/AloeStackViewObjc', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '9.0'
s.public_header_files = 'AloeStackViewObjc/Source/*.h'
s.source_files = 'AloeStackViewObjc/Source/*.{h,m}'
end
