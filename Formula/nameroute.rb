class Nameroute < Formula
  desc "Local TCP L7 Router - Name it. We route it."
  homepage "https://github.com/SpreadWorks/name-route"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.0/nameroute-aarch64-apple-darwin"
      sha256 "041176fe48effed004e7754ab625a8f5768af276dafe86a352c151be1c7ae28d"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.0/nameroute-x86_64-apple-darwin"
      sha256 "f6b7e53fd5259aacb943cd8d9e52c679aff024054db8a56681d9970616a17525"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.0/nameroute-aarch64-unknown-linux-gnu"
      sha256 "178124d9ecfa4b960c3a2527a20eb8c05fe35327288f8fe7d3201a65bad8450b"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.0/nameroute-x86_64-unknown-linux-gnu"
      sha256 "449bce6153bc16aa61a40927a6466937e62585b6cb43188b229ffff1ef84ad42"
    end
  end

  def install
    binary = Dir.glob("nameroute*").first
    mv binary, "nameroute" if binary != "nameroute"
    bin.install "nameroute"
  end

  service do
    run [opt_bin/"nameroute", "serve"]
    keep_alive true
    log_path var/"log/nameroute.log"
    error_log_path var/"log/nameroute.log"
  end

  test do
    assert_match "nameroute", shell_output("#{bin}/nameroute --help")
  end
end
