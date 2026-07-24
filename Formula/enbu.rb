class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.10"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_darwin_arm64.tar.gz"
    sha256 "69f1f4043f5ab0cc48bc7557d01fd493240cc43d3f4ea638744eb836430c87ce"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_arm64.tar.gz"
    sha256 "245afdd98ab9fd07b27b658a4eb40f42b2b0d11cd8c8c89e4fb672e61cf171e3"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_amd64.tar.gz"
    sha256 "4fa8d0b5a4bc621534c56a22bbb11874883a7e6f8b01e289a6cee537c6338340"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
