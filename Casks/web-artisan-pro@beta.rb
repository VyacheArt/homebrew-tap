cask "web-artisan-pro@beta" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0-beta.9"
  sha256 arm:   "ebe55915ba69acb2ed9c6debb6bf9c03a61ac87706ad82d454af0cc9911fb421",
         intel: "ba2e7526b37ab2b12ecaa3b41ea9506d1b7bc65f3c4cd53817bb548afe33a4ce"

  url "https://cdn.web-artisan.pro/releases/#{version}/web-artisan-pro-#{version}-macos-#{arch}.dmg"
  name "Web Artisan Pro"
  desc "Offline developer tools: converters, encoders and generators"
  homepage "https://web-artisan.pro/"

  auto_updates true
  conflicts_with cask: "web-artisan-pro"
  depends_on :macos

  app "Web Artisan Pro.app"

  zap trash: [
    "~/Library/Application Support/pro.web-artisan",
    "~/Library/Caches/velopack/pro.web-artisan",
    "~/Library/Logs/velopack_pro.web-artisan.log",
    "~/Library/Preferences/pro.web-artisan.plist",
  ]
end
