# Dotfiles

Synced through dropbox. Currently set up manually:

    ln -s ~/Dropbox/syncs/dotfiles/dotgitconfig .gitconfig


### Emacs keybindings for all.

Add this file: `~/Library/KeyBindings/DefaultKeyBinding.dict`

```
{
    "~d" = "deleteWordForward:";
    "^w" = "deleteWordBackward:";
    "~f" = "moveWordForward:";
    "~b" = "moveWordBackward:";
}
```

[source](http://blog.sensible.io/2012/10/19/mac-os-x-emacs-style-keybindings-everywhere.html)
