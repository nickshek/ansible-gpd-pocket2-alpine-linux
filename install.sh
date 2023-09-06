#!/bin/ash
TARGET_USER=$1
# Check if user exists
if id "$TARGET_USER" >/dev/null 2>&1; then
    echo "User $TARGET_USER exists"
else
    echo "User $TARGET_USER does not exist"
    exit 1
fi

setup-xorg-base

# Uncomment community repo in /etc/apk/repositories
sed -i '/^#.*community/s/^#//' /etc/apk/repositories

apk update
# Install doas for sudo
apk add doas-sudo-shim

# Install bash
apk add bash curl wget git libstdc++ gcompat ansible-core ansible
# Check if /etc/doas.d/doas.conf contains the line "permit persist $TARGET_USER as root", if not, add it
if grep -Fxq "permit persist $TARGET_USER as root" /etc/doas.d/doas.conf
then
    echo "doas.conf already contains the line \"permit persist $TARGET_USER as root\""
else
    echo "permit persist $TARGET_USER as root" >> /etc/doas.d/doas.conf
fi

# Update /etc/sshd/sshd_config.Remove AllowTcpForwarding no and add AllowTcpForwarding yes if not present
sed -i '/^AllowTcpForwarding no/d' /etc/ssh/sshd_config
if grep -Fxq "AllowTcpForwarding yes" /etc/ssh/sshd_config
then
    echo "sshd_config already contains the line \"AllowTcpForwarding yes\""
else
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
fi

# tell user to restart the sshd server
echo "Please restart the sshd server by running \"rc-service sshd restart\""