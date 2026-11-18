require "download_strategy"

class RecogReleaseDownloadStrategy < AbstractFileDownloadStrategy
  def fetch(timeout: nil)
    cached_location.dirname.mkpath
    lock = DownloadLock.new(temporary_path)
    begin
      lock.lock_or_wait(quiet: quiet?, timeout: timeout)
      unless cached_location.exist?
        gh = HOMEBREW_PREFIX/"bin/gh"
        gh = which("gh") unless gh.executable?
        raise "Install gh and run gh auth login with access to materkey/recog" unless gh

        system_command! gh, args: ["release", "download", "v#{version}",
                                   "--repo", "github.com/materkey/recog",
                                   "--pattern", File.basename(url),
                                   "--output", temporary_path.to_s, "--clobber"],
                            timeout: timeout
        temporary_path.rename(cached_location)
      end
      create_symlink_to_cached_download(cached_location)
    ensure
      lock.unlock(unlink: true)
    end
  end
end

class Recog < Formula
  desc "Live Russian conference transcription"
  homepage "https://github.com/materkey/recog"
  url "https://github.com/materkey/recog/releases/download/v0.1.3/recog-v0.1.3-macos-arm64.tar.gz", using: RecogReleaseDownloadStrategy
  version "0.1.3"
  sha256 "7f36809b860fe73eb4329163f4d41f5478c8f689b42ff26c9e0bb549a41c897e"
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
