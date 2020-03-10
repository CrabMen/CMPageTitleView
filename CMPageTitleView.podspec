Pod::Spec.new do |s|
    s.name         = 'CMPageTitleView'
    s.version      = '0.6.2'
    s.summary      = 'An easy way to use title bar'
    s.homepage     = 'https://github.com/CrabMen/CMPageTitleView'
    s.license      = 'MIT'
    s.authors      = {'CrabMan' => 'tobecrabman@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/CrabMen/CMPageTitleView.git', :tag => s.version}
    s.source_files = '**/**/Class/*.{h,m}'
    s.requires_arc = true
end
