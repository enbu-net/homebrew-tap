cask "enbu-desktop" do
  version "0.7.6"
  sha256 "3f6c31999176e39a0afaf05945e8cacf97c92fd83ce6b2d806254ef584e76bb5"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
