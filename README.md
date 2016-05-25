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

All files and directories will be symlinked to your home directory unless
included in `IGNORE` in `install.sh`.
