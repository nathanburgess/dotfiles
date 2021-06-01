# Installation
`git clone https://github.com/nathanburgess/dotfiles ~/dotfiles && sudo ~/dotfiles/install.sh && rm -fR ~/dotfiles`

## Multi-user Homebrew
### Create a user group
1. Open `Users & Groups` in `System Preferences`
2. Add a new `Group` account named `brew` and add the users you want to have access to the group
### Update permissions 
1. `sudo chgrp -R brew $(brew --prefix)`
2. `sudo chmod -R g+w $(brew --prefix)`
### Check that it works
Run `brew doctor` and ensure that it doesn't give you a persmission warning
