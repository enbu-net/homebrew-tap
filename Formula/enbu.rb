class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.2"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_darwin_arm64.tar.gz"
    sha256 "d62675aaabe09de9ec4d40c39c3d051297b070580186aeeb4b52e42ea261a566"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_linux_arm64.tar.gz"
    sha256 "39106bac5dbd098b2d63cc7283cd7450e26b1cc47f78613c8cb7c5db320f343c"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_linux_amd64.tar.gz"
    sha256 "09e238e5334ecfbf5ee3fe930bc51a6c5dd82c9588d8d7e8df9b0cedcd8c3e72"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
