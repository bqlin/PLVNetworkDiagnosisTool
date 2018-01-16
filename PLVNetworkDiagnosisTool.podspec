Pod::Spec.new do |s|

  s.name         = "PLVNetworkDiagnosisTool"
  s.version      = "0.0.1"
  s.summary      = "iOS 网络探测工具"
  s.description  = <<-DESC
  PLVNetworkDiagnosisTool
  iOS 网络探测工具
                   DESC
  s.homepage     = "https://github.com/bqlin/PLVNetworkDiagnosisTool"
  s.license      = { :type => "Apache License Version 2.0", :file => "LICENSE" }
  s.author             = { "bqlin" => "bqlins@163.com" }

  s.source       = { :git => "https://github.com/bqlin/PLVNetworkDiagnosisTool.git", :tag => "#{s.version}" }
  s.source_files  = "PLVNetworkDiagnosisTool/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, "8.0"
  s.libraries = "resolv"
  s.frameworks = "CoreTelephony"

end
