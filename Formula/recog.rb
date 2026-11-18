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
  url "https://github.com/materkey/recog/releases/download/v0.1.0/recog-v0.1.0-macos-arm64.tar.gz", using: RecogReleaseDownloadStrategy
  version "0.1.0"
  sha256 "cee01284c8d0d77609dd019667b16150631d31e5415f59c0c5df812361a28fa9"
  license "MIT"
  depends_on arch: :arm64
  depends_on :macos
  depends_on "ffmpeg"

  def install
    libexec.install Dir["*", ".env.example", ".claude"]
    (libexec/"recog-homebrew").write("1\n")
    bin.install_symlink libexec/"bin/recog"
  end

  test do
    assert_match "recog", shell_output("#{bin}/recog --help")
  end
end
