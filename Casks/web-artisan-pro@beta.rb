cask "web-artisan-pro@beta" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0-beta.10"
  sha256 arm:   "643a12245a6613ceafac5bfd2cece392f8f45c27f071b23f76206de0062985b9",
         intel: "fe071cae80f6ab41f9f70b83a57a1afa94cf0b7e29b0481f955b8c254a92cdcf"

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
