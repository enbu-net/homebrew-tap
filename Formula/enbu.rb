class Enbu < Formula
  desc "End-to-end encrypted .env management using GitHub"
  homepage "https://enbu.net/"
  version "0.7.9"
  license "MIT"

  if OS.mac?
    depends_on arch: :arm64

    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_darwin_arm64.tar.gz"
    sha256 "bebdbf49404644aa8d7253ed943d8cb35dd922e22f64a126d503bb4a6217779e"
  elsif Hardware::CPU.arm?
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_arm64.tar.gz"
    sha256 "b519f734fde99fc9e4b7490bc01cae7a734b3d75cf71bd1ea1004bc2c71cf4a6"
  else
    url "https://github.com/enbu-net/enbu/releases/download/v#{version}/enbu_v#{version}_linux_amd64.tar.gz"
    sha256 "bf57388c6894866a70e82869a780d5c4e6bcd0e35b31088bcd2ee061475eea12"
  end

  def install
    bin.install "enbu"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/enbu --version")
  end
end
