require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "Diffs"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => '16.0' }
  s.source       = { :git => "https://github.com/vercel-labs/react-native-diffs.git", :tag => "#{s.version}" }

  s.source_files = [
    "ios/**/*.{swift}",
    "ios/**/*.{m,mm}",
    "cpp/**/*.{hpp,cpp}",
  ]

  spm_dependency(s,
    url: "https://github.com/HumanInterfaceDesign/MarkdownView",
    requirement: { kind: "branch", branch: "main" }, # todo use version
    products: ["MarkdownView"]
  )

  s.dependency 'React-jsi'
  s.dependency 'React-callinvoker'

  load 'nitrogen/generated/ios/Diffs+autolinking.rb'
  add_nitrogen_files(s)

  install_modules_dependencies(s)
end
