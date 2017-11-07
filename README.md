# zsh-codestats

[Code::Stats](https://codestats.net/) plugin for [Zsh](http://www.zsh.org/).

This is highly experimental. Note that logging what you type in your shell as code written may be frowned upon by the Code::Stats community.

This plugin sends all the pulses using the language `zsh`. This should prevent confusion.

## Installation

Get your personal API key from https://codestats.net/my/machines and set environment variable `CODESTATS_API_KEY`.

### Manual installation

Clone this git repo and source the script directly.

```
CODESTATS_API_KEY="SFMyNTY.OEotWWdnPT0jI01qaz0.X0wVEZquh8Ogau1iTtBihYqqL71FD8N6p5ChQiIpaxQ"
source codestats.zsh
```

### Plugin managers (zgen, ...)

TODO

## Options

- `CODESTATS_API_KEY`: the API key used when submitting pulses. Required.
- `CODESTATS_API_URL`: the base URL to the Code::Stats API. Only set this if you know what you're doing! :)

## Other plugins

Plugins that wrap ZLE widgets should probably be loaded after `zsh-codestats`. For example, [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) needs to be loaded after `zsh-codestats` for it to work properly.

As a rule of thumb, loading `zsh-codestats` early is not a bad idea.
