#!/bin/ash
# Check if user argument is provided
TARGET_USER=$1
# Check if user exists
if id "$TARGET_USER" >/dev/null 2>&1; then
    echo "User $TARGET_USER exists"
else
    echo "User $TARGET_USER does not exist"
    exit 1
fi

# exit if current user is not root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Download and execute install.sh script with user argument
curl -s https://raw.githubusercontent.com/nickshek/ansible-gpd-pocket2-alpine-linux/master/install.sh | ash -s $TARGET_USER

# create ~/.tmp directory
mkdir -p ~/.tmp

# cd into ~/.tmp
cd ~/.tmp

# clone https://github.com/nickshek/ansible-gpd-pocket2-alpine-linux
git clone https://github.com/nickshek/ansible-gpd-pocket2-alpine-linux

# cd into ansible-gpd-pocket2-alpine-linux
cd ansible-gpd-pocket2-alpine-linux

# Download and execute ansible.sh script with user argument
./ansible.sh $TARGET_USER