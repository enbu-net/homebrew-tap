class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.8.0"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_darwin_arm64.tar.gz"
    sha256 "5771c4a2b12cdec95313ac142040d2d58d4c6219318306c52531d210f8c556c5"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_arm64.tar.gz"
    sha256 "8f63ec0d19925aa47999387f4cd12eb686fab2ec7ce5f6b96e6804c86b4d7d11"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_amd64.tar.gz"
    sha256 "b1e9b8fe964075e3a097be57263b230d58b825a7d46b670b5a77fbcae20feaa4"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
