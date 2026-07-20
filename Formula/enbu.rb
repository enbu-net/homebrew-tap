class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.3"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_darwin_arm64.tar.gz"
    sha256 "37bcf9c25c8d230c358b32f035f745252b88805fa5cc2d74c2888e62151eb764"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_linux_arm64.tar.gz"
    sha256 "6f259c972e48f358ce99891740342b1d3f5c8f0b943c9ada8783c608e9242d9b"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_#{version}_linux_amd64.tar.gz"
    sha256 "4ee60ae319deba4fc3f40146a783ed57b38e8839940cabc957e622de08025dd4"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
