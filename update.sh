#!/bin/sh
# Rewrites the casks from the release manifests: web-artisan-pro from the
# stable one, web-artisan-pro@beta from the beta one. A unique query string
# makes the CDN fetch them anew, so a run right after a release sees it.
set -eu

cd "$(dirname "$0")"

manifests=https://cdn.web-artisan.pro/manifest
fresh=$(date +%s)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# The SHA-256 of the DMG for ARCH. The cask builds the URL from the version
# and the arch, so the manifest must list the DMG under exactly this name.
sha256() {
  jq -r --arg url "https://cdn.web-artisan.pro/releases/$version/web-artisan-pro-$version-macos-$1.dmg" \
    '.files[] | select(.url == $url) | .sha256' "$work/manifest.json"
}

mkdir -p Casks
for channel in stable beta; do
  case $channel in
    stable) token=web-artisan-pro other=web-artisan-pro@beta ;;
    beta) token=web-artisan-pro@beta other=web-artisan-pro ;;
  esac
  status=$(curl -sS -o "$work/manifest.json" -w '%{http_code}' "$manifests/$channel.json?$fresh")
  case $status in
    200) ;;
    # Spaces answers 403 for a missing file, as for an access error. A channel
    # is never removed, so a miss for one that has a cask is an error.
    403 | 404)
      if [ -f "Casks/$token.rb" ]; then
        echo "update: $channel.json: HTTP $status" >&2
        exit 1
      fi
      continue
      ;;
    *)
      echo "update: $channel.json: HTTP $status" >&2
      exit 1
      ;;
  esac

  version=$(jq -r .version "$work/manifest.json")
  # A stable release lands in the beta manifest too, but its DMG carries the
  # stable channel, so the beta cask keeps the last beta.
  if [ "$channel" = beta ] && [ "${version%-beta.*}" = "$version" ]; then
    continue
  fi
  arm=$(sha256 arm64)
  intel=$(sha256 x64)
  if [ -z "$arm" ] || [ -z "$intel" ]; then
    echo "update: $channel.json has no macOS DMGs of $version" >&2
    exit 1
  fi

  cat > "Casks/$token.rb" <<EOF
cask "$token" do
  arch arm: "arm64", intel: "x64"

  version "$version"
  sha256 arm:   "$arm",
         intel: "$intel"

  url "https://cdn.web-artisan.pro/releases/#{version}/web-artisan-pro-#{version}-macos-#{arch}.dmg"
  name "Web Artisan Pro"
  desc "Offline developer tools: converters, encoders and generators"
  homepage "https://web-artisan.pro/"

  auto_updates true
  conflicts_with cask: "$other"
  depends_on :macos

  app "Web Artisan Pro.app"

  zap trash: [
    "~/Library/Application Support/pro.web-artisan",
    "~/Library/Caches/velopack/pro.web-artisan",
    "~/Library/Logs/velopack_pro.web-artisan.log",
    "~/Library/Preferences/pro.web-artisan.plist",
  ]
end
EOF
done
