# dotfiles
My dotfiles

## Install

Clone the repo and its submodules, then install links. The install will not override any configs by default.

```
git clone git@github.com:cw2095/dotfiles.git && \
cd .dotfiles && \
git submodule update --init --recursive && \
./install
```

If errors occur due to existing files, move them and try again. Per machine configuration will be run based on current hostname.

## Update

Pull the latest from git and re-run the installer:

```
git pull && \
git submodule update --init --recursive && \
./install
```
