class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.6"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_darwin_arm64.tar.gz"
    sha256 "f2349686870e1bf8a054bd79a656f89ba2780af0fd6b29e7f192c8d63a60395c"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_arm64.tar.gz"
    sha256 "a56b3baabc744e3653c13dfe8652b54e7d7df3639652ccb846af30e1851001f2"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_amd64.tar.gz"
    sha256 "24cb2dad116a16cdfe506d49f0c18dfe1cd79d94fc74617b9661ba936db3333b"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
