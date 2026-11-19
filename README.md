# Homebrew apps

## Recog

Install Recog on an Apple Silicon Mac with an account that can read
`materkey/recog`. Homebrew downloads a prebuilt archive from the private
GitHub release using your GitHub CLI login.

```sh
brew install gh
gh auth login --hostname github.com
brew install materkey/apps/recog
recog setup
```

If you already use `gh`, check the selected account with `gh auth status`.
To verify repository access, run `gh release view --repo materkey/recog`.
If Homebrew reports an untrusted tap, run `brew trust --formula materkey/apps/recog`
and repeat the install. This grants trust to the Recog formula only.
Run `recog update` for subsequent updates.
