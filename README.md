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

The `PATH` environment variable gets set at the end of `~/.bashrc`. It includes
`~/bin`, `~/.local/bin`, and `~/miniconda3/envs/bin/bin`. The latter is useful to
have a relatively clean conda environment that's used primarily for installing
binaries available from conda channels that should be available globally but
may not be available through the operating system, e.g., if operating on a
shared system without root privileges.
