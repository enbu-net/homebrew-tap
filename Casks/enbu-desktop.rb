cask "enbu-desktop" do
  version "0.7.5"
  sha256 "3b036051f45f4dd39b4e2651c17fce9e5c92a57bd25b084d93ad8f7ea6a954f8"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
