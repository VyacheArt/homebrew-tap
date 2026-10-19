cask "web-artisan-pro@beta" do
  arch arm: "arm64", intel: "x64"

  version "2.0.0-beta.8"
  sha256 arm:   "b4a53bfd36a64672d3dd0c2a430ca29836b6758c1f51872238624b05ced80294",
         intel: "b3b4cfcf635df417ea788c16a4380aa7ea588af0e255d5680836fefa58e39ea5"

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
