class Recog < Formula
  desc "Live Russian conference transcription"
  homepage "https://github.com/materkey/recog"
  url "https://github.com/materkey/recog/releases/download/v0.3.0/recog-v0.3.0-macos-arm64.tar.gz"
  version "0.3.0"
  sha256 "bb2e699ce33caea481eb75b845fe8435a85adf387d289b50dbd858b44cadb98b"
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
