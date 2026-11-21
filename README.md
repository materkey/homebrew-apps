# Homebrew apps

## Recog

### Install on macOS 13 or later (Apple Silicon)

1. [Download the Recog disk image](https://github.com/materkey/recog/releases/latest/download/Recog-macOS-arm64.dmg) and open it.
2. Drag `Recog.app` into **Applications**. In Finder, open **Applications** and launch **Recog**.
3. Follow the prompts to allow microphone and system audio recording. Recog will show you the Chrome extension folder.
4. In Chrome, open `chrome://extensions`, turn on **Developer mode**, click **Load unpacked** and select that folder.

The free beta is signed locally. If macOS warns that it cannot verify the developer, open **System Settings → Privacy & Security** and click **Open Anyway**.

Recog uses FFmpeg to process audio. Its license and the corresponding FFmpeg source are available inside `Recog.app`.

### Homebrew alternative

```sh
brew install materkey/apps/recog
recog setup
```

If Homebrew reports an untrusted tap, run `brew trust --formula materkey/apps/recog`
and repeat the install. This grants trust to the Recog formula only.
Run `recog update` for subsequent updates.
