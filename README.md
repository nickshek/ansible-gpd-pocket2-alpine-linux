# ANSIBLE GPD POCKET2 ALPINE LINUX

Post Alpine OS installation of your GPD Pocket 2 using ansible. Hope that this small project will give you some idea on how to setup alpine os using your gpd pocket 2

## Requirements

- Complete the installation of Alpine Linux on your GPD Pocket 2.

  - Please go to https://www.alpinelinux.org/ to download the latest version of Alpine Linux.

  - And you may go to https://etcher.balena.io/ to download the latest version of Etcher for make a bootable USB key.

- Create a user during the installation of Alpine Linux.



## Installation

- Install git by typing `apk add git`

- Clone this repository by typing `git clone https://github.com/nickshek/ansible-gpd-pocket2-alpine-linux`

- Go to the directory by typing `cd ansible-gpd-pocket2-alpine-linux`

- Change the user to root by typing `su`

- trigger `./install.sh <user>` where `<user>` is the user you created

- trigger `./ansible.sh <user>`

- reboot

## Reference

- https://www.ndhfilms.com/other/gpdpocket2

- https://github.com/stockmind/gpd-pocket-ubuntu-respin/issues/51

- https://pbat.ch/blog/posts/2019-02-18-alpine-gpd.html