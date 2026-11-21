# Homebrew apps

## Recog

Install Recog on an Apple Silicon Mac. Homebrew downloads the prebuilt archive
from the [public Recog release](https://github.com/materkey/recog/releases/latest).

```sh
brew install materkey/apps/recog
recog setup
```

If Homebrew reports an untrusted tap, run `brew trust --formula materkey/apps/recog`
and repeat the install. This grants trust to the Recog formula only.
Run `recog update` for subsequent updates.
