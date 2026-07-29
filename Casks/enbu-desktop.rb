cask "enbu-desktop" do
  version "0.8.0"
  sha256 "9f8703d3a3915fc61c1ffc38da19568451a0052b0dcbf467920a44816ac29aa8"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
