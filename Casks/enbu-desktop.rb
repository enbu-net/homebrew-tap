cask "enbu-desktop" do
  version "0.7.7"
  sha256 "6c9250eca4a1ce515abe5ce6a46fc37e1e535133f3f83e921064c80cca4a353c"

  url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu-desktop_v#{version}_darwin_arm64.dmg"
  name "enbu"
  desc "Desktop app for end-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"

  depends_on arch: :arm64

  app "enbu-desktop.app"

  # No zap stanza required
end
