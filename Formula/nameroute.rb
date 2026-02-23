class Nameroute < Formula
  desc "Local TCP L7 Router - Name it. We route it."
  homepage "https://github.com/SpreadWorks/name-route"
  version "0.1.1-rc.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.1-rc.1/nameroute-aarch64-apple-darwin"
      sha256 "f3ad902bd61fd44a70aada79dba4fd521a0e16993a54a9d39f6f449bf6daf26c"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.1-rc.1/nameroute-x86_64-apple-darwin"
      sha256 "9fc9c07533b2143ec1ad70953384c89f785e7048b1876a35c4c949ad7cba1fae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.1-rc.1/nameroute-aarch64-unknown-linux-gnu"
      sha256 "5502e6596dc80c5bdb1d9fc783996a95c36af98f322f006b52b411612111617a"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.1.1-rc.1/nameroute-x86_64-unknown-linux-gnu"
      sha256 "47033ccdb02a3b1884476b7f865c0afc2af136c42f498c075f2eb6a9f96b646c"
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
