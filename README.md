# zsh-codestats

[Code::Stats](https://codestats.net/) plugin for [Zsh](http://www.zsh.org/).

This plugin is an early beta, so expect some rough edges.

All the pulses are sent using the language `Terminal (Zsh)`.

## Installation

1. Ensure you have [`curl`](https://curl.haxx.se/).
1. Get your personal API key from https://codestats.net/my/machines and set environment variable in e.g. `.zshrc`.
    ```
    CODESTATS_API_KEY="<api key here>"
    ```
1. Install and source the script in one of the following ways (in `.zshrc` after the environment variable):

### Zgen

```
zgen load dancek/zsh-codestats
```

Add a line for the plugin, run `zgen update` and restart your terminal.

### Manual installation

Clone this git repo and source the script directly.

```
source codestats.zsh
```

### Other plugin managers (Zplug, Antigen, ...)

Probably just pointing to the git repo will work.


## Options

- `CODESTATS_API_KEY`: the API key used when submitting pulses. Required.
- `CODESTATS_API_URL`: the base URL to the Code::Stats API. Only set this if you know what you're doing! :)

## Other plugins

Plugins that wrap ZLE widgets should probably be loaded after `zsh-codestats`. For example, [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) needs to be loaded after `zsh-codestats` for it to work properly.
