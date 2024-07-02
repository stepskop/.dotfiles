# How to setup:

## Hyprland
Install `hyprland` wm based on you hardware configuration

## Install packages
```bash
yay -S $(cut -d '#' -f 1 package.lst)
```

## To enable **tuigreetd**
/etc/greetd/config.toml
```bash
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 1

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
command = "tuigreet --cmd Hyprland --remember"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "greeter"
```

## For **GTK theme** set themes in:

**.config/** <br>
qt5ct.conf <br>
qt6ct.conf <br>
kvantum.kvconfig <br>
hypr/themes/theme.conf <br>

## GNU Stow
```bash
stow --adopt .
```
