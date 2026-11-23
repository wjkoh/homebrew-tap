class Crashgate < Formula
  desc "Read-only deep-crash margin and tax-loss harvest watchdog for hledger"
  homepage "https://github.com/wjkoh/crashgate"
  url "https://github.com/wjkoh/crashgate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b0dd5609d020bea11c9b53485426095bcbe6b844f5e25e127c36f592e4cef7ce"
  license "Apache-2.0"
  head "https://github.com/wjkoh/crashgate.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/crashgate"
  end

  test do
    assert_match "crashgate #{version}", shell_output("#{bin}/crashgate --version")
  end
end
