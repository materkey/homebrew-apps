class Recog < Formula
  desc "Live Russian conference transcription"
  homepage "https://github.com/materkey/recog"
  url "https://github.com/materkey/recog/releases/download/v0.5.0/recog-v0.5.0-macos-arm64.tar.gz"
  version "0.5.0"
  sha256 "541ce56267217c5682b4d8f3b7a0f7a2afda6d8853ba3c97bac680c53fa65a93"
  license "MIT"
  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "ffmpeg"

  def install
    libexec.install Dir["*", ".env.example", ".claude"]
    # Homebrew preserves libexec metadata when the prefix already has its license.
    cp libexec/"LICENSE", prefix/"LICENSE"
    (libexec/"recog-homebrew").write("1\n")
    bin.install_symlink libexec/"bin/recog"
  end

  test do
    assert_predicate libexec/"CHANGELOG.md", :file?
    assert_predicate libexec/"LICENSE", :file?
    assert_match "recog", shell_output("#{bin}/recog --help")
  end
end
