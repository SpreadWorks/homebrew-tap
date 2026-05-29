class Nameroute < Formula
  desc "Local TCP L7 Router - Name it. We route it."
  homepage "https://github.com/SpreadWorks/name-route"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.4.0/nameroute-aarch64-apple-darwin"
      sha256 "8a4879a3a551226bcb170527d7cc69dc23c2d5adcfa1c65dab1c4ccddf7c0314"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.4.0/nameroute-x86_64-apple-darwin"
      sha256 "25fe1df1607896fd10d67acf9c0ec51aa696858206bf97cb2100629f16830db8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.4.0/nameroute-aarch64-unknown-linux-musl"
      sha256 "85a34af95624eb26a67b343f7eef614301e700329a238ebbffc0d789de094bcd"
    else
      url "https://github.com/SpreadWorks/name-route/releases/download/v0.4.0/nameroute-x86_64-unknown-linux-musl"
      sha256 "1f8d39f2ca44beea876460d05b44a7cbc3e2909c59c8099ad6809ea13891f339"
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
