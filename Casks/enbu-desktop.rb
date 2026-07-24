cask "enbu-desktop" do
  version "0.7.10"
  sha256 "2f43dc710e9147a4a5b16d5eedc3a92858c2da06de22d7591cceb0e18106259f"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
