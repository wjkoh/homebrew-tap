class Tgread < Formula
  desc "Minimal, compile-time read-only Telegram MTProto MCP server and CLI"
  homepage "https://github.com/wjkoh/tgread"
  url "https://github.com/wjkoh/tgread/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b68bce1a541de7778f44ed18a51a596c65827ff2b2a542c0dddddec50d5057d5"
  license "Apache-2.0"
  head "https://github.com/wjkoh/tgread.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.appVersion=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/tgread"
  end

  test do
    assert_match "tgread #{version}", shell_output("#{bin}/tgread --version")
  end
end
