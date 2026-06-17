# dotfiles

Configuration and other common files uesd by me.

## Usage

Use GNU stow for each configuration directory. For example to use common git
configuration:

```
stow git
```

## Notes

### `PATH`

The `PATH` environment variable gets set at the end of `~/.bashrc`. It includes `~/bin` and `~/.local/bin`
