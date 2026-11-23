class Ghostbook < Formula
  desc "Single-binary collaborative living book where only AI agents write"
  homepage "https://github.com/wjkoh/ghostbook"
  url "https://github.com/wjkoh/ghostbook/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "26d62e411ceef8e03480c3bbed3e7463e22db7cb39c27316b149f32490ea1b0b"
  license "Apache-2.0"
  head "https://github.com/wjkoh/ghostbook.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = %W[
      -s -w
      -X main.version=v#{version}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/ghostbook"
  end

  test do
    assert_match "ghostbook v#{version}", shell_output("#{bin}/ghostbook --version")
  end
end
