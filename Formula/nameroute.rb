class Nameroute < Formula
  desc "Local TCP L7 Router - Name it. We route it."
  homepage "https://github.com/SpreadWorks/name-route"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.3.0/nameroute-aarch64-apple-darwin"
      sha256 "b20391ac4e9dfbef372df30b2467f1a88b4692804c013325075f02ec99f27b0b"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.3.0/nameroute-x86_64-apple-darwin"
      sha256 "7f65946544bd2485ea5d94dd2eb3bb9d19ab87fc716a7b27bc591e33109d21e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.3.0/nameroute-aarch64-unknown-linux-musl"
      sha256 "d45b727cd8fe9ba7ce63460827183a558c587e53c66f3ccf2bc8634d72f32a67"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.3.0/nameroute-x86_64-unknown-linux-musl"
      sha256 "33a589c953c4368bea11a7caf867269effc5f0a4b8c0a0297abe651434c0fe8a"
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
