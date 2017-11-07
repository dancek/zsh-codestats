# zsh-codestats

[Code::Stats](https://codestats.net/) plugin for [Zsh](http://www.zsh.org/).

This is highly experimental. Note that logging what you type in your shell as code written may be frowned upon by the Code::Stats community.

This plugin sends all the pulses using the language `zsh`. This should prevent confusion.

## Installation

Clone this git repo.

```
source codestats.zsh
```

TODO: Code::Stats api key

TODO: zgen and other plugin managers

## Other plugins

Plugins that wrap ZLE widgets should probably be loaded after `zsh-codestats`. For example, [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) needs to be loaded after `zsh-codestats` for it to work properly.

As a rule of thumb, loading `zsh-codestats` is not a bad idea.
