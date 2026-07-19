# Homebrew tap for enbu

This tap provides the [enbu](https://enbu.net) command-line
tool and macOS desktop app.

## Install the CLI

```sh
brew install enbu-net/tap/enbu
```

The CLI supports Apple Silicon macOS and x86_64/ARM64 Linux.

## Install the desktop app

```sh
brew install --cask enbu-net/tap/enbu-desktop
```

The desktop app currently supports Apple Silicon macOS.

## Upgrade

```sh
brew update
brew upgrade enbu
brew upgrade --cask enbu-desktop
```

The tap checks the latest immutable GitHub release once a day and updates the
CLI and desktop definitions together from its published `checksums.txt`.
The update workflow can also be run manually from GitHub Actions.
