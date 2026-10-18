# Web Artisan Pro for Homebrew

Homebrew casks for the upcoming version 2 of Web Artisan Pro on macOS, Apple
Silicon and Intel. They install the signed and notarized DMG from
`cdn.web-artisan.pro`, the same one the website offers.

If you're here, it's your lucky day! Please don't tell your friends (yet).

| Channel | Cask |
|---|---|
| stable | `web-artisan-pro` |
| beta | `web-artisan-pro@beta` |

`web-artisan-pro` appears with the first stable release. Both casks install
the same app, so only one of them can be installed at a time.

## Install

```sh
brew install --cask vyacheart/tap/web-artisan-pro@beta
```

The full name trusts this one cask, so Homebrew needs no `brew tap` or
`brew trust` first.

The app updates itself and asks before it does. The casks declare
`auto_updates`, so `brew upgrade` replaces the app only when it is older
than the cask.

## Uninstall

```sh
brew uninstall --cask vyacheart/tap/web-artisan-pro@beta
```

With `--zap` it also removes the settings and the downloaded updates.

## Maintenance

`update.sh` rewrites the casks from the release manifests; it needs `curl`
and `jq`. The Update workflow runs it after each release and commits the
casks once `brew` installs the new DMG and Gatekeeper accepts the app.

The beta cask moves only with betas. A stable release lands in the beta
channel too, but its DMG carries the stable channel, and the app would leave
the beta with it.

## License

The casks here are under the MIT License, see [LICENSE](LICENSE).
Web Artisan Pro itself is proprietary software of PE Goriunov Viacheslav.
