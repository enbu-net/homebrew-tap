cask "enbu-desktop" do
  version "0.7.8"
  sha256 "a37462a556e22dc741ca98aa32907cb830efe5c6c38f8b503d0dd7ceafd6619d"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
