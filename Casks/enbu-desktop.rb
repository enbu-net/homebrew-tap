cask "enbu-desktop" do
  version "0.7.2"
  sha256 "e6cc667718a52f26f606973bd28f26a5067599ea45e99b4e7b5e9ff192fff41c"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
