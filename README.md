# ANSIBLE GPD POCKET2 ALPINE LINUX

Post Alpine OS installation of your GPD Pocket 2 using ansible

## Requirements

- Complete the installation of Alpine Linux on your GPD Pocket 2.

  - Please go to https://www.alpinelinux.org/ to download the latest version of Alpine Linux.

  - And you may go to https://etcher.balena.io/ to download the latest version of Etcher for make a bootable USB key.

- Create a user during the installation of Alpine Linux.

## Installation

- Change the user to root by typing `su`

- trigger `./install.sh <user>` where `<user>` is the user you created

- trigger `./ansible.sh <user>`

- reboot