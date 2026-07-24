class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.4"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_darwin_arm64.tar.gz"
    sha256 "f9786cbd50cbd89138d28fe9f1dc81baa519511e006e59d98639265e29fd4806"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_arm64.tar.gz"
    sha256 "332f8c3e559843d57e307b22f069d8aba222e0cae72ba3047a45624d76d68d6f"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_amd64.tar.gz"
    sha256 "226d3580f7d7952a4319147f60aa56bde7474edfebae2b83a3518fb9f172711e"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
