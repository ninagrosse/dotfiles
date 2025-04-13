# scripts-cachy

## CachyOS*

The `CachyOS*` files are lists of packages / desktop applications
that can be installed with `pacman` or `paru`. Packages that are already
installed are skipped. Requires KDE Plasma.

```shell
# install native/pacman packages
sudo pacman -S --needed - < CachyOS-packages_native.txt
```

```shell
# install AUR packages
paru -S --needed - < CachyOS-packages_aur.txt
```

```shell
# install gaming packages
paru -S --needed - < CachyOS-packages_gaming.txt
```

## `ufw-rules-backup.sh`

This script sets up `ufw` with rules needed by the `CachyOS*` packages.

```shell
# setup ufw
./ufw-rules-backup.sh
```
