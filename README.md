# .dotfiles

A collection of standard configuration files. Easy to move around. No frills
install script.

```bash
$ cd ~
$ git clone https://github.com/zhaorz/.dotfiles.git .dotfiles

$ cd .dotfiles
$ chmod a+x install.sh
$ ./install.sh
```

To add more files and folders, put them into the `.dotfiles` directory, remove
the leading dot (`.`), and add each name to the `FILES` list in `install.sh`.

Upon running `install.sh`, if conflicting dotfiles are in the `$HOME` path, they
will be moved to the `.dotfiles_backup` directory.
