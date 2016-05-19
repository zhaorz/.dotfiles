#!/bin/bash
#
# install.sh
# Create symlinks from the home directory
# to specified files in ~/.dotfiles
#
# Richard Zhao
#

SRC="$HOME/.dotfiles"               # Source files
BACKUP="$HOME/.dotfiles_backup"     # Backup of files that get replaced by symlinks

# Space separated string of files/folders in SRC to symlink
FILES="\
  bashrc bash_profile \
  editorconfig \
  hushlogin \
  slate \
  tmux.conf \
  vimrc vim"

# Create BACKUP directory
echo "Creating backup directory at $BACKUP"
mkdir -p $BACKUP
echo "... done."

# Move existing dotfiles in ~ to BACKUP then create symlinks.
cd $SRC
for FILENAME in $FILES; do
  if [ -e "$HOME/.$FILENAME" ]; then
    mv "$HOME/.$FILENAME" "$BACKUP"
    echo "Created backup: $FILENAME"
  fi
  ln -s "$SRC/$FILENAME" "$HOME/.$FILENAME"
  echo "Created symlink: $FILENAME"
done

# Symlink bin
if [ -e "$HOME/bin" ]; then
  mv "$HOME/bin" "$BACKUP"
  echo "Created backup: bin/"
fi
ln -s "$SRC/bin" "$HOME/bin"
echo "Created symlink: bin/"
