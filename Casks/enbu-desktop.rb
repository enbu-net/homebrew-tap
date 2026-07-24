cask "enbu-desktop" do
  version "0.7.9"
  sha256 "4f6115a65fd80cb748d97374ad6a0b912090d8c75ee218e66fda0fe1f52790b9"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
