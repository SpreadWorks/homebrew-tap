class Nameroute < Formula
  desc "Local TCP L7 Router - Name it. We route it."
  homepage "https://github.com/SpreadWorks/name-route"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.2.0/nameroute-aarch64-apple-darwin"
      sha256 "a75df3f14cf9dd8c16cfcff2b40a0d01309ba8e1f9c9cc3ab8e1efc7ab4d7a00"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.2.0/nameroute-x86_64-apple-darwin"
      sha256 "73e92932edf6af6ee50f137b203733014685db618cb0afdb8010c6c79771b114"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.2.0/nameroute-aarch64-unknown-linux-musl"
      sha256 "3e6e4790ddd583350560a4052e6120befd6fda6d6cc0d8f6c4b3d732fa53b1df"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.2.0/nameroute-x86_64-unknown-linux-musl"
      sha256 "35062fc9bbabf5b77d4f7ce04e38bd387aad8daa17fc6a15b6ca6462a02431dc"
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
